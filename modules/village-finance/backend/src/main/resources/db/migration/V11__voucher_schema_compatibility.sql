SET search_path TO village_finance_ops, public;

-- Compatibility columns for legacy fin_voucher schema.
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS id BIGINT;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS book_id BIGINT;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS period_id BIGINT;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS attachment_count INT;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS status VARCHAR(16);
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS audited_by BIGINT;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS audited_at TIMESTAMP;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS biz_id BIGINT;
ALTER TABLE fin_voucher ADD COLUMN IF NOT EXISTS remark VARCHAR(255);

-- Keep id usable for MyBatis-Plus selectById/updateById/insert auto-id.
CREATE SEQUENCE IF NOT EXISTS fin_voucher_id_seq;
ALTER TABLE fin_voucher ALTER COLUMN id SET DEFAULT nextval('fin_voucher_id_seq');

-- Backfill id/book mapping from legacy columns.
UPDATE fin_voucher
SET id = voucher_id
WHERE id IS NULL AND voucher_id IS NOT NULL;

UPDATE fin_voucher
SET id = nextval('fin_voucher_id_seq')
WHERE id IS NULL;

SELECT setval(
    'fin_voucher_id_seq',
    GREATEST(COALESCE((SELECT MAX(id) FROM fin_voucher), 1), 1),
    true
);

UPDATE fin_voucher
SET book_id = village_id
WHERE book_id IS NULL AND village_id IS NOT NULL;

-- Map period_id from period_month/voucher_date to fin_period(period_year, period_no).
UPDATE fin_voucher fv
SET period_id = fp.id
FROM fin_period fp
WHERE fv.period_id IS NULL
  AND fv.book_id = fp.book_id
  AND fp.period_year = EXTRACT(YEAR FROM COALESCE(fv.period_month, fv.voucher_date))::INT
  AND fp.period_no = EXTRACT(MONTH FROM COALESCE(fv.period_month, fv.voucher_date))::INT;

UPDATE fin_voucher
SET attachment_count = 0
WHERE attachment_count IS NULL;

ALTER TABLE fin_voucher ALTER COLUMN attachment_count SET DEFAULT 0;

-- Normalize status to frozen ledger/report semantics.
UPDATE fin_voucher
SET status = CASE
    WHEN UPPER(COALESCE(voucher_status, '')) IN ('AUDITED', 'APPROVED', 'POSTED', 'DONE', 'SUCCESS') THEN 'AUDITED'
    ELSE 'DRAFT'
END
WHERE status IS NULL;

ALTER TABLE fin_voucher ALTER COLUMN status SET DEFAULT 'DRAFT';

UPDATE fin_voucher
SET audited_by = approved_by
WHERE audited_by IS NULL AND approved_by IS NOT NULL;

UPDATE fin_voucher
SET audited_at = updated_at
WHERE audited_at IS NULL AND updated_at IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uk_fin_voucher_id ON fin_voucher(id);
CREATE INDEX IF NOT EXISTS idx_fin_voucher_book_period ON fin_voucher(book_id, period_id);
CREATE INDEX IF NOT EXISTS idx_fin_voucher_status ON fin_voucher(status);
CREATE INDEX IF NOT EXISTS idx_fin_voucher_type_biz ON fin_voucher(voucher_type, biz_id);
