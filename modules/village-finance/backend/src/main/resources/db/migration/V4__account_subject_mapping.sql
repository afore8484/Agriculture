SET search_path TO village_finance_ops, public;

ALTER TABLE fin_bank_account
    ADD COLUMN IF NOT EXISTS subject_id BIGINT;

ALTER TABLE fin_cash_account
    ADD COLUMN IF NOT EXISTS subject_id BIGINT;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints
        WHERE table_schema = 'village_finance_ops'
          AND table_name = 'fin_bank_account'
          AND constraint_name = 'fk_fin_bank_account_subject'
    ) THEN
        ALTER TABLE fin_bank_account
            ADD CONSTRAINT fk_fin_bank_account_subject
                FOREIGN KEY (subject_id) REFERENCES fin_subject(id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints
        WHERE table_schema = 'village_finance_ops'
          AND table_name = 'fin_cash_account'
          AND constraint_name = 'fk_fin_cash_account_subject'
    ) THEN
        ALTER TABLE fin_cash_account
            ADD CONSTRAINT fk_fin_cash_account_subject
                FOREIGN KEY (subject_id) REFERENCES fin_subject(id);
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_fin_bank_account_subject ON fin_bank_account(subject_id);
CREATE INDEX IF NOT EXISTS idx_fin_cash_account_subject ON fin_cash_account(subject_id);
