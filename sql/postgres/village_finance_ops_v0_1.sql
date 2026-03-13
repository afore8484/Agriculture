-- PostgreSQL 16
-- Village Finance Operations Schema (v0.1)

CREATE SCHEMA IF NOT EXISTS village_finance_ops;
SET search_path TO village_finance_ops, public;

-- =========================
-- Identity and Organization
-- =========================

CREATE TABLE IF NOT EXISTS sys_user (
    user_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username             VARCHAR(64) NOT NULL UNIQUE,
    display_name         VARCHAR(128) NOT NULL,
    status               VARCHAR(16) NOT NULL DEFAULT 'active',
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS sys_role (
    role_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_code            VARCHAR(32) NOT NULL UNIQUE,
    role_name            VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS sys_user_role (
    user_id              BIGINT NOT NULL,
    role_id              BIGINT NOT NULL,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_user_role_user FOREIGN KEY (user_id) REFERENCES sys_user(user_id),
    CONSTRAINT fk_user_role_role FOREIGN KEY (role_id) REFERENCES sys_role(role_id)
);

CREATE TABLE IF NOT EXISTS dim_region (
    region_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    region_code          VARCHAR(32) NOT NULL UNIQUE,
    region_name          VARCHAR(128) NOT NULL,
    region_level         SMALLINT NOT NULL,
    parent_region_code   VARCHAR(32),
    is_active            BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS dim_village (
    village_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_code         VARCHAR(64) NOT NULL UNIQUE,
    village_name         VARCHAR(128) NOT NULL,
    region_code          VARCHAR(32) NOT NULL,
    account_set_created  BOOLEAN NOT NULL DEFAULT FALSE,
    status               VARCHAR(16) NOT NULL DEFAULT 'active',
    CONSTRAINT fk_village_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code)
);

-- =========================
-- Finance Center
-- =========================

CREATE TABLE IF NOT EXISTS fin_voucher (
    voucher_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    voucher_no           VARCHAR(64) NOT NULL UNIQUE,
    voucher_date         DATE NOT NULL,
    period_month         DATE NOT NULL,
    voucher_type         VARCHAR(32) NOT NULL,
    source_type          VARCHAR(32) NOT NULL,
    total_debit          NUMERIC(20,2) NOT NULL DEFAULT 0,
    total_credit         NUMERIC(20,2) NOT NULL DEFAULT 0,
    voucher_status       VARCHAR(24) NOT NULL DEFAULT 'DRAFT',
    created_by           BIGINT NOT NULL,
    approved_by          BIGINT,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_voucher_village FOREIGN KEY (village_id) REFERENCES dim_village(village_id),
    CONSTRAINT fk_voucher_creator FOREIGN KEY (created_by) REFERENCES sys_user(user_id),
    CONSTRAINT fk_voucher_approver FOREIGN KEY (approved_by) REFERENCES sys_user(user_id)
);

CREATE TABLE IF NOT EXISTS fin_voucher_line (
    line_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    voucher_id           BIGINT NOT NULL,
    line_no              INTEGER NOT NULL,
    subject_code         VARCHAR(32) NOT NULL,
    subject_name         VARCHAR(128) NOT NULL,
    debit_amount         NUMERIC(20,2) NOT NULL DEFAULT 0,
    credit_amount        NUMERIC(20,2) NOT NULL DEFAULT 0,
    summary              TEXT,
    CONSTRAINT fk_voucher_line_voucher FOREIGN KEY (voucher_id) REFERENCES fin_voucher(voucher_id),
    CONSTRAINT uq_voucher_line UNIQUE (voucher_id, line_no)
);

CREATE TABLE IF NOT EXISTS fin_cash_journal (
    cash_journal_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    txn_date             DATE NOT NULL,
    period_month         DATE NOT NULL,
    income_amount        NUMERIC(20,2) NOT NULL DEFAULT 0,
    expense_amount       NUMERIC(20,2) NOT NULL DEFAULT 0,
    balance_amount       NUMERIC(20,2) NOT NULL DEFAULT 0,
    summary              TEXT,
    voucher_id           BIGINT,
    created_by           BIGINT NOT NULL,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_cash_village FOREIGN KEY (village_id) REFERENCES dim_village(village_id),
    CONSTRAINT fk_cash_voucher FOREIGN KEY (voucher_id) REFERENCES fin_voucher(voucher_id)
);

CREATE TABLE IF NOT EXISTS fin_bank_journal (
    bank_journal_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    bank_account_no      VARCHAR(64) NOT NULL,
    txn_date             DATE NOT NULL,
    period_month         DATE NOT NULL,
    txn_direction        VARCHAR(8) NOT NULL,
    txn_amount           NUMERIC(20,2) NOT NULL,
    counterparty_name    VARCHAR(128),
    summary              TEXT,
    voucher_id           BIGINT,
    created_by           BIGINT NOT NULL,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_bank_village FOREIGN KEY (village_id) REFERENCES dim_village(village_id),
    CONSTRAINT fk_bank_voucher FOREIGN KEY (voucher_id) REFERENCES fin_voucher(voucher_id)
);

CREATE TABLE IF NOT EXISTS fin_period_close (
    close_id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    period_month         DATE NOT NULL,
    close_status         VARCHAR(16) NOT NULL DEFAULT 'OPEN',
    closed_by            BIGINT,
    closed_at            TIMESTAMPTZ,
    CONSTRAINT uq_close UNIQUE (village_id, period_month)
);

-- =========================
-- Workflow and Payment
-- =========================

CREATE TABLE IF NOT EXISTS wf_process_def (
    process_def_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    process_code         VARCHAR(64) NOT NULL UNIQUE,
    process_name         VARCHAR(128) NOT NULL,
    process_status       VARCHAR(16) NOT NULL DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS wf_step_def (
    step_def_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    process_def_id       BIGINT NOT NULL,
    step_no              INTEGER NOT NULL,
    step_name            VARCHAR(128) NOT NULL,
    role_code            VARCHAR(32) NOT NULL,
    CONSTRAINT fk_step_process FOREIGN KEY (process_def_id) REFERENCES wf_process_def(process_def_id),
    CONSTRAINT uq_step UNIQUE (process_def_id, step_no)
);

CREATE TABLE IF NOT EXISTS wf_instance (
    process_instance_id  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    process_def_id       BIGINT NOT NULL,
    business_type        VARCHAR(32) NOT NULL,
    business_id          BIGINT NOT NULL,
    instance_status      VARCHAR(24) NOT NULL DEFAULT 'IN_PROGRESS',
    started_by           BIGINT NOT NULL,
    started_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    ended_at             TIMESTAMPTZ,
    CONSTRAINT fk_instance_def FOREIGN KEY (process_def_id) REFERENCES wf_process_def(process_def_id)
);

CREATE TABLE IF NOT EXISTS wf_task (
    task_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    process_instance_id  BIGINT NOT NULL,
    step_no              INTEGER NOT NULL,
    assignee_user_id     BIGINT NOT NULL,
    task_status          VARCHAR(24) NOT NULL DEFAULT 'PENDING',
    action               VARCHAR(24),
    action_comment       TEXT,
    action_at            TIMESTAMPTZ,
    CONSTRAINT fk_task_instance FOREIGN KEY (process_instance_id) REFERENCES wf_instance(process_instance_id),
    CONSTRAINT fk_task_assignee FOREIGN KEY (assignee_user_id) REFERENCES sys_user(user_id)
);

CREATE TABLE IF NOT EXISTS pay_order (
    pay_order_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    pay_no               VARCHAR(64) NOT NULL UNIQUE,
    pay_date             DATE NOT NULL,
    pay_amount           NUMERIC(20,2) NOT NULL,
    payee_name           VARCHAR(128) NOT NULL,
    payee_account_no     VARCHAR(64),
    pay_purpose          TEXT,
    pay_status           VARCHAR(24) NOT NULL DEFAULT 'DRAFT',
    process_instance_id  BIGINT,
    created_by           BIGINT NOT NULL,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_pay_village FOREIGN KEY (village_id) REFERENCES dim_village(village_id),
    CONSTRAINT fk_pay_instance FOREIGN KEY (process_instance_id) REFERENCES wf_instance(process_instance_id)
);

CREATE TABLE IF NOT EXISTS pay_execution (
    pay_execution_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pay_order_id         BIGINT NOT NULL,
    endpoint_id          BIGINT,
    bank_txn_no          VARCHAR(128),
    execute_status       VARCHAR(24) NOT NULL,
    bank_result_code     VARCHAR(32),
    bank_result_msg      TEXT,
    executed_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_execution_order FOREIGN KEY (pay_order_id) REFERENCES pay_order(pay_order_id)
);

-- =========================
-- Report Center
-- =========================

CREATE TABLE IF NOT EXISTS rpt_balance_sheet (
    rpt_id               BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    period_month         DATE NOT NULL,
    line_code            VARCHAR(32) NOT NULL,
    line_name            VARCHAR(128) NOT NULL,
    begin_value          NUMERIC(20,2) NOT NULL DEFAULT 0,
    end_value            NUMERIC(20,2) NOT NULL DEFAULT 0,
    delta_value          NUMERIC(20,2) NOT NULL DEFAULT 0,
    CONSTRAINT uq_rpt_bs UNIQUE (village_id, period_month, line_code)
);

CREATE TABLE IF NOT EXISTS rpt_income_distribution (
    rpt_id               BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    period_month         DATE NOT NULL,
    item_code            VARCHAR(32) NOT NULL,
    item_name            VARCHAR(128) NOT NULL,
    amount               NUMERIC(20,2) NOT NULL DEFAULT 0,
    CONSTRAINT uq_rpt_income UNIQUE (village_id, period_month, item_code)
);

CREATE TABLE IF NOT EXISTS rpt_bookkeeping_progress (
    progress_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    period_month         DATE NOT NULL,
    voucher_total        INTEGER NOT NULL DEFAULT 0,
    voucher_approved     INTEGER NOT NULL DEFAULT 0,
    voucher_pending      INTEGER NOT NULL DEFAULT 0,
    close_status         VARCHAR(16) NOT NULL DEFAULT 'OPEN',
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_progress UNIQUE (village_id, period_month)
);

-- =========================
-- Asset and Contract
-- =========================

CREATE TABLE IF NOT EXISTS ast_asset_card (
    asset_id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    asset_code           VARCHAR(64) NOT NULL UNIQUE,
    asset_name           VARCHAR(128) NOT NULL,
    asset_type           VARCHAR(32) NOT NULL,
    original_value       NUMERIC(20,2) NOT NULL,
    net_value            NUMERIC(20,2) NOT NULL,
    acquire_date         DATE,
    asset_status         VARCHAR(24) NOT NULL DEFAULT 'IN_USE',
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS ast_asset_change_log (
    change_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    asset_id             BIGINT NOT NULL,
    change_type          VARCHAR(32) NOT NULL,
    old_value            TEXT,
    new_value            TEXT,
    change_reason        TEXT,
    changed_by           BIGINT NOT NULL,
    changed_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_asset_change FOREIGN KEY (asset_id) REFERENCES ast_asset_card(asset_id)
);

CREATE TABLE IF NOT EXISTS ctr_contract (
    contract_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    contract_no          VARCHAR(64) NOT NULL UNIQUE,
    contract_name        VARCHAR(256) NOT NULL,
    contract_type        VARCHAR(32) NOT NULL,
    contract_amount      NUMERIC(20,2) NOT NULL DEFAULT 0,
    sign_date            DATE,
    start_date           DATE,
    end_date             DATE,
    contract_status      VARCHAR(24) NOT NULL DEFAULT 'ACTIVE',
    created_by           BIGINT NOT NULL,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS ctr_acceptance (
    acceptance_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contract_id          BIGINT NOT NULL,
    acceptance_result    VARCHAR(16) NOT NULL,
    acceptance_note      TEXT,
    accepted_by          BIGINT NOT NULL,
    accepted_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_acceptance_contract FOREIGN KEY (contract_id) REFERENCES ctr_contract(contract_id)
);

CREATE TABLE IF NOT EXISTS ctr_termination (
    termination_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contract_id          BIGINT NOT NULL,
    terminate_reason     TEXT NOT NULL,
    terminate_date       DATE NOT NULL,
    terminated_by        BIGINT NOT NULL,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_termination_contract FOREIGN KEY (contract_id) REFERENCES ctr_contract(contract_id)
);

-- =========================
-- Bank Direct and Party
-- =========================

CREATE TABLE IF NOT EXISTS bank_endpoint_config (
    endpoint_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bank_type_name       VARCHAR(64) NOT NULL,
    service_host         VARCHAR(256) NOT NULL,
    service_port         INTEGER,
    ftp_host             VARCHAR(256),
    ftp_port             INTEGER,
    ftp_username         VARCHAR(128),
    ftp_password_cipher  TEXT,
    config_status        VARCHAR(16) NOT NULL DEFAULT 'ACTIVE',
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS bank_account (
    bank_account_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    endpoint_id          BIGINT,
    bank_name            VARCHAR(128) NOT NULL,
    account_no           VARCHAR(64) NOT NULL UNIQUE,
    account_status       VARCHAR(24) NOT NULL DEFAULT 'NORMAL',
    current_balance      NUMERIC(20,2) NOT NULL DEFAULT 0,
    frozen_amount        NUMERIC(20,2) NOT NULL DEFAULT 0,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_bank_account_endpoint FOREIGN KEY (endpoint_id) REFERENCES bank_endpoint_config(endpoint_id)
);

CREATE TABLE IF NOT EXISTS bank_receipt_download_log (
    receipt_log_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    bank_account_id      BIGINT NOT NULL,
    receipt_date         DATE NOT NULL,
    receipt_type         VARCHAR(32),
    downloaded_by        BIGINT NOT NULL,
    downloaded_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    file_url             TEXT,
    CONSTRAINT fk_receipt_account FOREIGN KEY (bank_account_id) REFERENCES bank_account(bank_account_id)
);

CREATE TABLE IF NOT EXISTS party_org (
    party_org_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    org_name             VARCHAR(256) NOT NULL,
    parent_org_id        BIGINT,
    member_count         INTEGER NOT NULL DEFAULT 0,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS party_member (
    party_member_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    village_id           BIGINT NOT NULL,
    member_name          VARCHAR(128) NOT NULL,
    gender               VARCHAR(8),
    join_party_date      DATE,
    party_org_id         BIGINT,
    member_status        VARCHAR(24) NOT NULL DEFAULT 'ACTIVE',
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_party_member_org FOREIGN KEY (party_org_id) REFERENCES party_org(party_org_id)
);

CREATE TABLE IF NOT EXISTS party_learning_course (
    course_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_title         VARCHAR(256) NOT NULL,
    course_type          VARCHAR(32) NOT NULL,
    publish_status       VARCHAR(16) NOT NULL DEFAULT 'PUBLISHED',
    published_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS party_learning_progress (
    progress_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_id            BIGINT NOT NULL,
    party_member_id      BIGINT NOT NULL,
    progress_percent     NUMERIC(5,2) NOT NULL DEFAULT 0,
    study_minutes        INTEGER NOT NULL DEFAULT 0,
    note_text            TEXT,
    score                NUMERIC(6,2),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_learning UNIQUE (course_id, party_member_id),
    CONSTRAINT fk_learning_course FOREIGN KEY (course_id) REFERENCES party_learning_course(course_id),
    CONSTRAINT fk_learning_member FOREIGN KEY (party_member_id) REFERENCES party_member(party_member_id)
);

-- =========================
-- Audit logs and indexes
-- =========================

CREATE TABLE IF NOT EXISTS op_audit_log (
    audit_log_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actor_user_id        BIGINT,
    action_type          VARCHAR(64) NOT NULL,
    object_type          VARCHAR(64) NOT NULL,
    object_id            VARCHAR(64) NOT NULL,
    action_result        VARCHAR(16) NOT NULL,
    detail_json          JSONB,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_voucher_village_period ON fin_voucher(village_id, period_month);
CREATE INDEX IF NOT EXISTS idx_voucher_status ON fin_voucher(voucher_status, created_at);
CREATE INDEX IF NOT EXISTS idx_wf_task_assignee_status ON wf_task(assignee_user_id, task_status);
CREATE INDEX IF NOT EXISTS idx_pay_order_status ON pay_order(pay_status, created_at);
CREATE INDEX IF NOT EXISTS idx_contract_status ON ctr_contract(contract_status, updated_at);
CREATE INDEX IF NOT EXISTS idx_asset_status ON ast_asset_card(asset_status, updated_at);
