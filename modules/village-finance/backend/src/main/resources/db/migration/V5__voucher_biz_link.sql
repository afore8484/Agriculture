SET search_path TO village_finance_ops, public;

ALTER TABLE fin_voucher
    ADD COLUMN IF NOT EXISTS biz_id BIGINT;

ALTER TABLE fin_voucher_recycle
    ADD COLUMN IF NOT EXISTS biz_id BIGINT;

CREATE INDEX IF NOT EXISTS idx_fin_voucher_type_biz
    ON fin_voucher(voucher_type, biz_id);
