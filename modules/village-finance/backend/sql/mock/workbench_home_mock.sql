SET search_path TO village_finance_ops, public;

DO $$
DECLARE
    v_region_code CONSTANT VARCHAR(32) := '460800';
    v_village_code CONSTANT VARCHAR(32) := '460801001';
    v_book_id CONSTANT BIGINT := 900001;
    v_org_id CONSTANT BIGINT := 460801001;
    v_period_jan CONSTANT BIGINT := 900001;
    v_period_feb CONSTANT BIGINT := 900002;
    v_period_mar CONSTANT BIGINT := 900003;
    v_period_apr CONSTANT BIGINT := 900004;
    v_period_may CONSTANT BIGINT := 900005;
    v_period_jun CONSTANT BIGINT := 900006;
    v_bank_subject CONSTANT BIGINT := 900102;
    v_cash_subject CONSTANT BIGINT := 900101;
    v_income_subject CONSTANT BIGINT := 900201;
    v_expense_subject CONSTANT BIGINT := 900202;
    v_asset_subject CONSTANT BIGINT := 900301;
    v_village_id BIGINT;
    v_creator_user_id BIGINT;
    v_auditor_user_id BIGINT;
BEGIN
    INSERT INTO dim_region (region_code, region_name, region_level, parent_region_code, is_active)
    VALUES (v_region_code, '琼海市', 2, NULL, TRUE)
    ON CONFLICT (region_code) DO UPDATE
        SET region_name = EXCLUDED.region_name,
            region_level = EXCLUDED.region_level,
            is_active = EXCLUDED.is_active;

    INSERT INTO dim_village (village_code, village_name, region_code, account_set_created, status)
    VALUES (v_village_code, '博鳌镇椰林村', v_region_code, TRUE, 'ACTIVE')
    ON CONFLICT (village_code) DO UPDATE
        SET village_name = EXCLUDED.village_name,
            region_code = EXCLUDED.region_code,
            account_set_created = EXCLUDED.account_set_created,
            status = EXCLUDED.status
    RETURNING village_id INTO v_village_id;

    IF v_village_id IS NULL THEN
        SELECT village_id
          INTO v_village_id
          FROM dim_village
         WHERE village_code = v_village_code
         LIMIT 1;
    END IF;

    IF v_village_id IS NULL THEN
        RAISE EXCEPTION 'dim_village init failed for %', v_village_code;
    END IF;

    INSERT INTO sys_user (username, display_name, status)
    VALUES ('finance_admin', '财务管理员', 'ENABLE')
    ON CONFLICT (username) DO UPDATE
        SET username = EXCLUDED.username,
            display_name = EXCLUDED.display_name,
            status = EXCLUDED.status,
            updated_at = CURRENT_TIMESTAMP
    RETURNING user_id INTO v_creator_user_id;

    INSERT INTO sys_user (username, display_name, status)
    VALUES ('finance_auditor', '财务审核员', 'ENABLE')
    ON CONFLICT (username) DO UPDATE
        SET username = EXCLUDED.username,
            display_name = EXCLUDED.display_name,
            status = EXCLUDED.status,
            updated_at = CURRENT_TIMESTAMP
    RETURNING user_id INTO v_auditor_user_id;

    IF v_creator_user_id IS NULL THEN
        SELECT user_id INTO v_creator_user_id FROM sys_user WHERE username = 'finance_admin' LIMIT 1;
    END IF;
    IF v_auditor_user_id IS NULL THEN
        SELECT user_id INTO v_auditor_user_id FROM sys_user WHERE username = 'finance_auditor' LIMIT 1;
    END IF;

    INSERT INTO fin_book (id, book_code, book_name, org_id, org_code, fiscal_year, currency, start_date, end_date, status, remark)
    VALUES (v_book_id, 'MOCK_BOOK_2026', '博鳌镇椰林村2026账套', v_org_id, '博鳌镇椰林村', 2026, 'CNY',
            DATE '2026-01-01', DATE '2026-12-31', 'ENABLE', 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET book_code = EXCLUDED.book_code,
            book_name = EXCLUDED.book_name,
            org_id = EXCLUDED.org_id,
            org_code = EXCLUDED.org_code,
            fiscal_year = EXCLUDED.fiscal_year,
            currency = EXCLUDED.currency,
            start_date = EXCLUDED.start_date,
            end_date = EXCLUDED.end_date,
            status = EXCLUDED.status,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_period (id, book_id, period_year, period_no, start_date, end_date, close_status)
    VALUES
        (v_period_jan, v_book_id, 2026, 1, DATE '2026-01-01', DATE '2026-01-31', 'CLOSED'),
        (v_period_feb, v_book_id, 2026, 2, DATE '2026-02-01', DATE '2026-02-28', 'CLOSED'),
        (v_period_mar, v_book_id, 2026, 3, DATE '2026-03-01', DATE '2026-03-31', 'OPEN'),
        (v_period_apr, v_book_id, 2026, 4, DATE '2026-04-01', DATE '2026-04-30', 'OPEN'),
        (v_period_may, v_book_id, 2026, 5, DATE '2026-05-01', DATE '2026-05-31', 'OPEN'),
        (v_period_jun, v_book_id, 2026, 6, DATE '2026-06-01', DATE '2026-06-30', 'OPEN')
    ON CONFLICT (id) DO UPDATE
        SET book_id = EXCLUDED.book_id,
            period_year = EXCLUDED.period_year,
            period_no = EXCLUDED.period_no,
            start_date = EXCLUDED.start_date,
            end_date = EXCLUDED.end_date,
            close_status = EXCLUDED.close_status,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_subject (id, book_id, subject_code, subject_name, category_id, balance_direction, level, is_leaf, enable_flag, assist_flag, remark)
    VALUES
        (900101, v_book_id, '100101', '库存现金', 900001, 'DEBIT', 1, 1, 1, 0, 'dashboard mock'),
        (900102, v_book_id, '100201', '银行存款', 900001, 'DEBIT', 1, 1, 1, 0, 'dashboard mock'),
        (900201, v_book_id, '600101', '村集体收入', 900002, 'CREDIT', 1, 1, 1, 0, 'dashboard mock'),
        (900202, v_book_id, '500101', '管理费用', 900002, 'DEBIT', 1, 1, 1, 0, 'dashboard mock'),
        (900301, v_book_id, '160101', '固定资产', 900003, 'DEBIT', 1, 1, 1, 0, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET book_id = EXCLUDED.book_id,
            subject_code = EXCLUDED.subject_code,
            subject_name = EXCLUDED.subject_name,
            category_id = EXCLUDED.category_id,
            balance_direction = EXCLUDED.balance_direction,
            level = EXCLUDED.level,
            is_leaf = EXCLUDED.is_leaf,
            enable_flag = EXCLUDED.enable_flag,
            assist_flag = EXCLUDED.assist_flag,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_bank_account (id, book_id, account_name, bank_name, account_no, init_balance, current_balance, status, subject_id, remark)
    VALUES (900001, v_book_id, '椰林村基本户', '海南农商行', '622202600000000001', 1200000.00, 1385000.00, 'ENABLE', v_bank_subject, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET book_id = EXCLUDED.book_id,
            account_name = EXCLUDED.account_name,
            bank_name = EXCLUDED.bank_name,
            account_no = EXCLUDED.account_no,
            init_balance = EXCLUDED.init_balance,
            current_balance = EXCLUDED.current_balance,
            status = EXCLUDED.status,
            subject_id = EXCLUDED.subject_id,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_cash_account (id, book_id, account_name, init_balance, current_balance, status, subject_id, remark)
    VALUES (900001, v_book_id, '椰林村库存现金', 50000.00, 38000.00, 'ENABLE', v_cash_subject, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET book_id = EXCLUDED.book_id,
            account_name = EXCLUDED.account_name,
            init_balance = EXCLUDED.init_balance,
            current_balance = EXCLUDED.current_balance,
            status = EXCLUDED.status,
            subject_id = EXCLUDED.subject_id,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_asset_category (id, category_code, category_name, depreciation_years, depreciation_method, residual_rate, enable_flag, created_by, remark)
    VALUES
        (900001, 'ASSET_CAT_001', '固定资产', 10, 'STRAIGHT_LINE', 5.00, 1, v_creator_user_id, 'dashboard mock'),
        (900002, 'ASSET_CAT_002', '流动资产', 1, 'STRAIGHT_LINE', 0.00, 1, v_creator_user_id, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET category_code = EXCLUDED.category_code,
            category_name = EXCLUDED.category_name,
            depreciation_years = EXCLUDED.depreciation_years,
            depreciation_method = EXCLUDED.depreciation_method,
            residual_rate = EXCLUDED.residual_rate,
            enable_flag = EXCLUDED.enable_flag,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_asset_card (
        id, asset_code, asset_name, category_id, book_id, org_id, purchase_date, original_value, net_value,
        accumulated_depreciation, depreciation_method, depreciation_years, residual_rate, location, keeper_name,
        status, enable_flag, created_by, remark
    )
    VALUES
        (900001, 'AST-0001', '村委办公楼', 900001, v_book_id, v_org_id, DATE '2020-03-01', 3200000.00, 2800000.00,
         400000.00, 'STRAIGHT_LINE', 20, 5.00, '村委办公区', '张三', 'USING', 1, v_creator_user_id, 'dashboard mock'),
        (900002, 'AST-0002', '农机设备', 900001, v_book_id, v_org_id, DATE '2022-06-15', 950000.00, 810000.00,
         140000.00, 'STRAIGHT_LINE', 10, 5.00, '农机仓库', '李四', 'USING', 1, v_creator_user_id, 'dashboard mock'),
        (900003, 'AST-0003', '流动资产包', 900002, v_book_id, v_org_id, DATE '2026-01-10', 580000.00, 580000.00,
         0.00, 'STRAIGHT_LINE', 1, 0.00, '财务室', '王五', 'USING', 1, v_creator_user_id, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET asset_code = EXCLUDED.asset_code,
            asset_name = EXCLUDED.asset_name,
            category_id = EXCLUDED.category_id,
            book_id = EXCLUDED.book_id,
            org_id = EXCLUDED.org_id,
            purchase_date = EXCLUDED.purchase_date,
            original_value = EXCLUDED.original_value,
            net_value = EXCLUDED.net_value,
            accumulated_depreciation = EXCLUDED.accumulated_depreciation,
            depreciation_method = EXCLUDED.depreciation_method,
            depreciation_years = EXCLUDED.depreciation_years,
            residual_rate = EXCLUDED.residual_rate,
            location = EXCLUDED.location,
            keeper_name = EXCLUDED.keeper_name,
            status = EXCLUDED.status,
            enable_flag = EXCLUDED.enable_flag,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_asset_depreciation (id, asset_id, book_id, period_label, depreciation_amount, accumulated_amount, net_value_after, voucher_id, created_by, remark)
    VALUES (900001, 900002, v_book_id, '2026-06', 6200.00, 146200.00, 803800.00, 910008, v_creator_user_id, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET asset_id = EXCLUDED.asset_id,
            book_id = EXCLUDED.book_id,
            period_label = EXCLUDED.period_label,
            depreciation_amount = EXCLUDED.depreciation_amount,
            accumulated_amount = EXCLUDED.accumulated_amount,
            net_value_after = EXCLUDED.net_value_after,
            voucher_id = EXCLUDED.voucher_id,
            remark = EXCLUDED.remark;

    INSERT INTO fin_asset_disposal (id, asset_id, disposal_type, disposal_date, disposal_income, disposal_loss, net_value, voucher_id, status, created_by, remark)
    VALUES (900001, 900003, 'SCRAP', DATE '2026-06-20', 2000.00, 500.00, 2500.00, 910010, 'NORMAL', v_creator_user_id, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET asset_id = EXCLUDED.asset_id,
            disposal_type = EXCLUDED.disposal_type,
            disposal_date = EXCLUDED.disposal_date,
            disposal_income = EXCLUDED.disposal_income,
            disposal_loss = EXCLUDED.disposal_loss,
            net_value = EXCLUDED.net_value,
            voucher_id = EXCLUDED.voucher_id,
            status = EXCLUDED.status,
            remark = EXCLUDED.remark;

    INSERT INTO fin_contract_main (
        id, contract_no, contract_name, contract_type, contract_amount, sign_date, start_date, end_date,
        counterparty_unit, counterparty_person, org_id, book_id, status, enable_flag, created_by, remark
    )
    VALUES
        (900001, 'CTR-2026-0001', '椰林村农产品销售合同', 'SALE', 80000.00, DATE '2026-06-01', DATE '2026-06-01', DATE '2026-12-31',
         '琼海农贸公司', '陈海', v_org_id, v_book_id, 'NORMAL', 1, v_creator_user_id, 'dashboard mock'),
        (900002, 'CTR-2026-0002', '椰林村设备采购合同', 'PROCUREMENT', 30000.00, DATE '2026-06-02', DATE '2026-06-02', DATE '2026-12-31',
         '海南设备供应商', '王强', v_org_id, v_book_id, 'NORMAL', 1, v_creator_user_id, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET contract_no = EXCLUDED.contract_no,
            contract_name = EXCLUDED.contract_name,
            contract_type = EXCLUDED.contract_type,
            contract_amount = EXCLUDED.contract_amount,
            sign_date = EXCLUDED.sign_date,
            start_date = EXCLUDED.start_date,
            end_date = EXCLUDED.end_date,
            counterparty_unit = EXCLUDED.counterparty_unit,
            counterparty_person = EXCLUDED.counterparty_person,
            org_id = EXCLUDED.org_id,
            book_id = EXCLUDED.book_id,
            status = EXCLUDED.status,
            enable_flag = EXCLUDED.enable_flag,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_contract_payment (
        id, contract_id, payment_type, payment_date, amount, bank_account_id, cash_account_id, journal_id, voucher_id, status, created_by, remark
    )
    VALUES
        (900001, 900001, 'RECEIPT', DATE '2026-06-12', 80000.00, 900001, NULL, NULL, 910006, 'NORMAL', v_creator_user_id, 'dashboard mock'),
        (900002, 900002, 'PAYMENT', DATE '2026-06-15', 15800.00, 900001, NULL, NULL, 910007, 'NORMAL', v_creator_user_id, 'dashboard mock'),
        (900003, 900001, 'RECEIPT', DATE '2026-05-12', 72000.00, 900001, NULL, NULL, 910005, 'NORMAL', v_creator_user_id, 'dashboard mock'),
        (900004, 900002, 'PAYMENT', DATE '2026-04-09', 25600.00, 900001, NULL, NULL, 910004, 'NORMAL', v_creator_user_id, 'dashboard mock'),
        (900005, 900001, 'RECEIPT', DATE '2026-03-20', 46800.00, 900001, NULL, NULL, 910003, 'NORMAL', v_creator_user_id, 'dashboard mock'),
        (900006, 900002, 'PAYMENT', DATE '2026-02-17', 19300.00, 900001, NULL, NULL, 910002, 'NORMAL', v_creator_user_id, 'dashboard mock'),
        (900007, 900001, 'RECEIPT', DATE '2026-01-11', 38200.00, 900001, NULL, NULL, 910001, 'NORMAL', v_creator_user_id, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET contract_id = EXCLUDED.contract_id,
            payment_type = EXCLUDED.payment_type,
            payment_date = EXCLUDED.payment_date,
            amount = EXCLUDED.amount,
            bank_account_id = EXCLUDED.bank_account_id,
            cash_account_id = EXCLUDED.cash_account_id,
            journal_id = EXCLUDED.journal_id,
            voucher_id = EXCLUDED.voucher_id,
            status = EXCLUDED.status,
            remark = EXCLUDED.remark;

    INSERT INTO fin_internal_transfer (
        id, book_id, from_account_id, from_account_type, to_account_id, to_account_type, txn_date, amount, voucher_id, status, operator_id, remark
    )
    VALUES
        (900001, v_book_id, 900001, 'BANK', 900001, 'CASH', DATE '2026-06-18', 12000.00, NULL, 'SUCCESS', v_creator_user_id, 'URGENT 内部转账'),
        (900002, v_book_id, 900001, 'BANK', 900001, 'CASH', DATE '2026-06-19', 6800.00, NULL, 'SUCCESS', v_creator_user_id, '普通内部转账')
    ON CONFLICT (id) DO UPDATE
        SET book_id = EXCLUDED.book_id,
            from_account_id = EXCLUDED.from_account_id,
            from_account_type = EXCLUDED.from_account_type,
            to_account_id = EXCLUDED.to_account_id,
            to_account_type = EXCLUDED.to_account_type,
            txn_date = EXCLUDED.txn_date,
            amount = EXCLUDED.amount,
            voucher_id = EXCLUDED.voucher_id,
            status = EXCLUDED.status,
            operator_id = EXCLUDED.operator_id,
            remark = EXCLUDED.remark;

    INSERT INTO fin_approve_process (id, process_code, process_name, biz_type, version_no, enable_flag, remark, created_by)
    VALUES
        (900001, 'APPROVAL_TRANSFER', '内部转账审批流程', 'TRANSFER', 1, 1, 'dashboard mock', v_creator_user_id),
        (900002, 'APPROVAL_CONTRACT', '合同收付款审批流程', 'CONTRACT_PAYMENT', 1, 1, 'dashboard mock', v_creator_user_id)
    ON CONFLICT (id) DO UPDATE
        SET process_code = EXCLUDED.process_code,
            process_name = EXCLUDED.process_name,
            biz_type = EXCLUDED.biz_type,
            version_no = EXCLUDED.version_no,
            enable_flag = EXCLUDED.enable_flag,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_approve_instance (
        id, process_id, biz_type, biz_id, instance_no, applicant_id, current_node, approve_status, start_time, remark, created_at, updated_at
    )
    VALUES
        (900001, 900001, 'TRANSFER', 900001, 'INS-TRANSFER-0001', v_creator_user_id, '财务复核', 'PROCESSING', CURRENT_TIMESTAMP, 'URGENT 备用金转账审批', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
        (900002, 900001, 'TRANSFER', 900002, 'INS-TRANSFER-0002', v_creator_user_id, '财务复核', 'PROCESSING', CURRENT_TIMESTAMP, '普通内部转账审批', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
        (900003, 900002, 'CONTRACT_PAYMENT', 900002, 'INS-CONTRACT-0001', v_creator_user_id, '合同付款审批', 'PROCESSING', CURRENT_TIMESTAMP, '设备采购付款审批', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
    ON CONFLICT (id) DO UPDATE
        SET process_id = EXCLUDED.process_id,
            biz_type = EXCLUDED.biz_type,
            biz_id = EXCLUDED.biz_id,
            instance_no = EXCLUDED.instance_no,
            applicant_id = EXCLUDED.applicant_id,
            current_node = EXCLUDED.current_node,
            approve_status = EXCLUDED.approve_status,
            start_time = EXCLUDED.start_time,
            remark = EXCLUDED.remark,
            updated_at = CURRENT_TIMESTAMP;

    INSERT INTO fin_approve_task (
        id, instance_id, task_no, node_name, approver_id, task_status, action_type, action_time, action_remark, created_at, updated_at
    )
    VALUES
        (900001, 900001, 'TASK-TRANSFER-0001', '紧急审批', v_creator_user_id, 'PENDING', NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
        (900002, 900002, 'TASK-TRANSFER-0002', '常规审批', v_creator_user_id, 'PENDING', NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
        (900003, 900003, 'TASK-CONTRACT-0001', '付款审批', v_creator_user_id, 'PENDING', NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
    ON CONFLICT (id) DO UPDATE
        SET instance_id = EXCLUDED.instance_id,
            task_no = EXCLUDED.task_no,
            node_name = EXCLUDED.node_name,
            approver_id = EXCLUDED.approver_id,
            task_status = EXCLUDED.task_status,
            action_type = EXCLUDED.action_type,
            action_time = EXCLUDED.action_time,
            action_remark = EXCLUDED.action_remark,
            updated_at = CURRENT_TIMESTAMP;

    DELETE FROM fin_voucher_entry
     WHERE voucher_id IN (900001, 910001, 910002, 910003, 910004, 910005, 910006, 910007, 910008, 910009, 910010);

    DELETE FROM fin_voucher
     WHERE voucher_id IN (900001, 910001, 910002, 910003, 910004, 910005, 910006, 910007, 910008, 910009, 910010);

    INSERT INTO fin_voucher (
        voucher_id, village_id, voucher_no, voucher_date, period_month, voucher_type, source_type,
        total_debit, total_credit, voucher_status, created_by, approved_by, created_at, updated_at,
        id, book_id, period_id, attachment_count, status, audited_by, audited_at, biz_id, remark
    )
    OVERRIDING SYSTEM VALUE
    VALUES
        (910001, v_village_id, 'PZ-2026-0101', DATE '2026-01-11', DATE '2026-01-01', 'CONTRACT_RECEIPT', 'BIZ', 38200.00, 38200.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910001, v_book_id, v_period_jan, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900007, '1月合同收款'),
        (910002, v_village_id, 'PZ-2026-0201', DATE '2026-02-17', DATE '2026-02-01', 'CONTRACT_PAYMENT', 'BIZ', 19300.00, 19300.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910002, v_book_id, v_period_feb, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900006, '2月合同付款'),
        (910003, v_village_id, 'PZ-2026-0301', DATE '2026-03-20', DATE '2026-03-01', 'CONTRACT_RECEIPT', 'BIZ', 46800.00, 46800.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910003, v_book_id, v_period_mar, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900005, '3月合同收款'),
        (910004, v_village_id, 'PZ-2026-0401', DATE '2026-04-09', DATE '2026-04-01', 'CONTRACT_PAYMENT', 'BIZ', 25600.00, 25600.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910004, v_book_id, v_period_apr, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900004, '4月合同付款'),
        (910005, v_village_id, 'PZ-2026-0501', DATE '2026-05-12', DATE '2026-05-01', 'CONTRACT_RECEIPT', 'BIZ', 72000.00, 72000.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910005, v_book_id, v_period_may, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900003, '5月合同收款'),
        (910006, v_village_id, 'PZ-2026-0601', DATE '2026-06-12', DATE '2026-06-01', 'CONTRACT_RECEIPT', 'BIZ', 80000.00, 80000.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910006, v_book_id, v_period_jun, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900001, '6月合同收款'),
        (910007, v_village_id, 'PZ-2026-0602', DATE '2026-06-15', DATE '2026-06-01', 'CONTRACT_PAYMENT', 'BIZ', 15800.00, 15800.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910007, v_book_id, v_period_jun, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900002, '6月合同付款'),
        (910008, v_village_id, 'PZ-2026-0603', DATE '2026-06-16', DATE '2026-06-01', 'ASSET_DEPRECIATION', 'BIZ', 6200.00, 6200.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910008, v_book_id, v_period_jun, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900001, '6月资产折旧'),
        (910009, v_village_id, 'PZ-2026-0604', DATE '2026-06-18', DATE '2026-06-01', 'MANUAL', 'MANUAL', 5000.00, 5000.00, 'DRAFT', v_creator_user_id, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910009, v_book_id, v_period_jun, 0, 'DRAFT', NULL, NULL, NULL, '6月草稿凭证'),
        (910010, v_village_id, 'PZ-2026-0605', DATE '2026-06-20', DATE '2026-06-01', 'ASSET_DISPOSAL', 'BIZ', 2500.00, 2500.00, 'AUDITED', v_creator_user_id, v_auditor_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 910010, v_book_id, v_period_jun, 0, 'AUDITED', v_auditor_user_id, CURRENT_TIMESTAMP, 900001, '6月资产处置')
    ON CONFLICT (voucher_id) DO UPDATE
        SET village_id = EXCLUDED.village_id,
            voucher_no = EXCLUDED.voucher_no,
            voucher_date = EXCLUDED.voucher_date,
            period_month = EXCLUDED.period_month,
            voucher_type = EXCLUDED.voucher_type,
            source_type = EXCLUDED.source_type,
            total_debit = EXCLUDED.total_debit,
            total_credit = EXCLUDED.total_credit,
            voucher_status = EXCLUDED.voucher_status,
            created_by = EXCLUDED.created_by,
            approved_by = EXCLUDED.approved_by,
            created_at = EXCLUDED.created_at,
            updated_at = EXCLUDED.updated_at,
            id = EXCLUDED.id,
            book_id = EXCLUDED.book_id,
            period_id = EXCLUDED.period_id,
            attachment_count = EXCLUDED.attachment_count,
            status = EXCLUDED.status,
            audited_by = EXCLUDED.audited_by,
            audited_at = EXCLUDED.audited_at,
            biz_id = EXCLUDED.biz_id,
            remark = EXCLUDED.remark;

    INSERT INTO fin_voucher_entry (id, voucher_id, line_no, subject_id, summary, debit_amount, credit_amount, sort_order, remark)
    VALUES
        (920001, 910001, 1, v_bank_subject, '1月合同收款入账', 38200.00, 0.00, 1, 'dashboard mock'),
        (920002, 910001, 2, v_income_subject, '1月合同收款入账', 0.00, 38200.00, 2, 'dashboard mock'),
        (920003, 910002, 1, v_expense_subject, '2月合同付款入账', 19300.00, 0.00, 1, 'dashboard mock'),
        (920004, 910002, 2, v_bank_subject, '2月合同付款入账', 0.00, 19300.00, 2, 'dashboard mock'),
        (920005, 910003, 1, v_bank_subject, '3月合同收款入账', 46800.00, 0.00, 1, 'dashboard mock'),
        (920006, 910003, 2, v_income_subject, '3月合同收款入账', 0.00, 46800.00, 2, 'dashboard mock'),
        (920007, 910004, 1, v_expense_subject, '4月合同付款入账', 25600.00, 0.00, 1, 'dashboard mock'),
        (920008, 910004, 2, v_bank_subject, '4月合同付款入账', 0.00, 25600.00, 2, 'dashboard mock'),
        (920009, 910005, 1, v_bank_subject, '5月合同收款入账', 72000.00, 0.00, 1, 'dashboard mock'),
        (920010, 910005, 2, v_income_subject, '5月合同收款入账', 0.00, 72000.00, 2, 'dashboard mock'),
        (920011, 910006, 1, v_bank_subject, '6月合同收款入账', 80000.00, 0.00, 1, 'dashboard mock'),
        (920012, 910006, 2, v_income_subject, '6月合同收款入账', 0.00, 80000.00, 2, 'dashboard mock'),
        (920013, 910007, 1, v_expense_subject, '6月合同付款入账', 15800.00, 0.00, 1, 'dashboard mock'),
        (920014, 910007, 2, v_bank_subject, '6月合同付款入账', 0.00, 15800.00, 2, 'dashboard mock'),
        (920015, 910008, 1, v_expense_subject, '6月资产折旧入账', 6200.00, 0.00, 1, 'dashboard mock'),
        (920016, 910008, 2, v_asset_subject, '6月资产折旧入账', 0.00, 6200.00, 2, 'dashboard mock'),
        (920017, 910009, 1, v_expense_subject, '6月草稿凭证', 5000.00, 0.00, 1, 'dashboard mock'),
        (920018, 910009, 2, v_cash_subject, '6月草稿凭证', 0.00, 5000.00, 2, 'dashboard mock'),
        (920019, 910010, 1, v_bank_subject, '6月资产处置入账', 2500.00, 0.00, 1, 'dashboard mock'),
        (920020, 910010, 2, v_asset_subject, '6月资产处置入账', 0.00, 2500.00, 2, 'dashboard mock')
    ON CONFLICT (id) DO UPDATE
        SET voucher_id = EXCLUDED.voucher_id,
            line_no = EXCLUDED.line_no,
            subject_id = EXCLUDED.subject_id,
            summary = EXCLUDED.summary,
            debit_amount = EXCLUDED.debit_amount,
            credit_amount = EXCLUDED.credit_amount,
            sort_order = EXCLUDED.sort_order,
            remark = EXCLUDED.remark;
END $$;
