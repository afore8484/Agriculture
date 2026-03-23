SET search_path TO village_finance_ops;

-- ===============================================
-- Village Finance baseline mock data (idempotent)
-- ===============================================

INSERT INTO fin_book (id, book_code, book_name, org_id, org_code, fiscal_year, currency, start_date, end_date, status, remark)
VALUES (900001, 'MOCK_BOOK_2026', '示例账套2026', 900001, 'MOCK_ORG_001', 2026, 'CNY', DATE '2026-01-01', DATE '2026-12-31', 'ENABLE', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_permission (id, permission_code, permission_name, permission_type, enable_flag)
VALUES (900001, 'finance:mock:view', '示例权限', 'BUTTON', 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO sys_dict (id, dict_type, dict_code, dict_label, dict_value, enable_flag)
VALUES (900001, 'FIN_STATUS', 'ENABLE', '启用', 'ENABLE', 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_period (id, book_id, period_year, period_no, start_date, end_date, close_status)
VALUES (900001, 900001, 2026, 3, DATE '2026-03-01', DATE '2026-03-31', 'OPEN')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_subject_category (id, category_code, category_name, balance_direction, enable_flag)
VALUES
    (900001, 'ASSET', '资产类', 'DEBIT', 1),
    (900002, 'INCOME', '收入类', 'CREDIT', 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_subject (id, book_id, subject_code, subject_name, parent_code, category_id, balance_direction, level, is_leaf, enable_flag, assist_flag, remark)
VALUES
    (900101, 900001, '100101', '库存现金', NULL, 900001, 'DEBIT', 1, 1, 1, 0, 'mock'),
    (900102, 900001, '100201', '银行存款', NULL, 900001, 'DEBIT', 1, 1, 1, 0, 'mock'),
    (900201, 900001, '600101', '村集体收入', NULL, 900002, 'CREDIT', 1, 1, 1, 0, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_subject_opening (id, book_id, subject_id, opening_year, opening_period, opening_debit, opening_credit)
VALUES
    (900001, 900001, 900101, 2026, 1, 1000.00, 0.00),
    (900002, 900001, 900102, 2026, 1, 5000.00, 0.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_subject_balance (id, book_id, period_id, subject_id, opening_debit, opening_credit, period_debit, period_credit, closing_debit, closing_credit)
VALUES
    (900001, 900001, 900001, 900101, 1000.00, 0.00, 200.00, 50.00, 1150.00, 0.00),
    (900002, 900001, 900001, 900102, 5000.00, 0.00, 1000.00, 200.00, 5800.00, 0.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_assist_category (id, assist_code, assist_name, assist_type, enable_flag)
VALUES (900001, 'DEPT', '部门辅助核算', 'ORG', 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_assist_item (id, assist_category_id, item_code, item_name, status)
VALUES (900001, 900001, 'DEPT001', '示例部门', 'ENABLE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_subject_assist_config (id, subject_id, assist_category_id, required_flag, enable_flag)
VALUES (900001, 900201, 900001, 0, 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_bank_account (id, book_id, account_name, bank_name, account_no, init_balance, current_balance, status, subject_id, remark)
VALUES (900001, 900001, '示例银行账户', '农业银行', '622202600000000001', 5000.00, 5800.00, 'ENABLE', 900102, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_cash_account (id, book_id, account_name, init_balance, current_balance, status, subject_id, remark)
VALUES (900001, 900001, '示例现金账户', 1000.00, 1150.00, 'ENABLE', 900101, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_no_rule (id, book_id, prefix, date_pattern, padding_len, current_no, reset_rule, status)
VALUES (900001, 900001, 'PZ', 'yyyyMM', 4, 2, 'MONTH', 'ENABLE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_print_config (id, book_id, print_title, page_size, show_auditor, show_attachment, status)
VALUES (900001, 900001, '记账凭证', 'A4', 1, 1, 'ENABLE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_template (id, template_code, template_name, book_id, biz_type, summary_rule, status, created_by)
VALUES (900001, 'TPL_TRANSFER', '内部转账模板', 900001, 'TRANSFER', '内部转账自动制证', 'ENABLE', 900001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_entry (id, voucher_id, line_no, subject_id, summary, debit_amount, credit_amount, sort_order, remark)
VALUES
    (900001, 900001, 1, 900101, '内部转入', 200.00, 0.00, 1, 'mock'),
    (900002, 900001, 2, 900102, '内部转出', 0.00, 200.00, 2, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_attachment (id, voucher_id, file_name, file_url, file_size, uploaded_by)
VALUES (900001, 900001, 'voucher.pdf', '/mock/voucher/900001.pdf', 1024, 900001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_audit_log (id, voucher_id, audit_action, auditor_id, remark)
VALUES (900001, 900001, 'AUDIT', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_recycle (id, original_voucher_id, voucher_no, voucher_date, voucher_type, book_id, period_id, total_debit, total_credit, deleted_by, voucher_snapshot, remark)
VALUES (900001, 900001, 'REC-202603-0001', DATE '2026-03-18', 'TRANSFER', 900001, 900001, 200.00, 200.00, 900001, '{}', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_recycle_entry (id, recycle_id, line_no, subject_id, summary, debit_amount, credit_amount, assist_json, remark)
VALUES (900001, 900001, 1, 900101, '回收分录', 200.00, 0.00, '{}', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_operation_log (id, voucher_id, operation_type, operator_id, operation_desc, before_json, after_json, remark)
VALUES (900001, 900001, 'CREATE', 900001, '创建凭证', '{}', '{}', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_voucher_assist_entry (id, voucher_entry_id, assist_category_id, assist_item_id, assist_amount, remark)
VALUES (900001, 900001, 900001, 900001, 200.00, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_internal_transfer (id, book_id, from_account_id, from_account_type, to_account_id, to_account_type, txn_date, amount, voucher_id, status, operator_id, remark)
VALUES (900001, 900001, 900001, 'BANK', 900001, 'CASH', DATE '2026-03-18', 200.00, NULL, 'SUCCESS', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_reconciliation (id, book_id, period_id, account_id, account_type, account_name, book_balance, bank_balance, diff_amount)
VALUES (900001, 900001, 900001, 900001, 'BANK', '示例银行账户', 5800.00, 5800.00, 0.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_bank_receipt (id, bank_account_id, journal_id, receipt_no, receipt_date, file_url, download_status)
VALUES (900001, 900001, NULL, 'RCPT-202603-0001', DATE '2026-03-18', '/mock/receipt/900001.pdf', 'SUCCESS')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_income_template (id, template_code, template_name, book_id, status, created_by)
VALUES (900001, 'INCOME_BASE', '收入模板', 900001, 'ENABLE', 900001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_income_template_item (id, template_id, line_no, subject_id, summary_rule, amount, direction, remark)
VALUES (900001, 900001, 1, 900201, '示例收入', 100.00, 'CREDIT', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_expense_template (id, template_code, template_name, book_id, status, created_by)
VALUES (900001, 'EXPENSE_BASE', '支出模板', 900001, 'ENABLE', 900001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_expense_template_item (id, template_id, line_no, subject_id, summary_rule, amount, direction, remark)
VALUES (900001, 900001, 1, 900102, '示例支出', 80.00, 'CREDIT', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_cashier_init_template (id, template_code, template_name, book_id, status, created_by)
VALUES (900001, 'CASHIER_INIT', '出纳初始化模板', 900001, 'ENABLE', 900001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_cashier_init_template_item (id, template_id, line_no, item_name, item_value, remark)
VALUES (900001, 900001, 1, '初始库存现金', '1000.00', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_cashier_init_template_version (id, template_id, version_no, publish_flag, created_by, remark)
VALUES (900001, 900001, 1, 1, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_cashier_init_template_auth (id, template_id, auth_type, auth_value)
VALUES (900001, 900001, 'ROLE', 'MOCK_FINANCE')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_cashier_init_template_stat (id, template_id, stat_date, apply_count, success_count, fail_count)
VALUES (900001, 900001, DATE '2026-03-18', 1, 1, 0)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_book_log (id, book_id, operation_type, operator_id, before_json, after_json, remark)
VALUES (900001, 900001, 'INIT', 900001, '{}', '{}', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_multicolumn_ledger_config (id, book_id, subject_id, column_code, column_name, sort_order, enable_flag)
VALUES (900001, 900001, 900201, 'COL_INCOME', '收入栏', 1, 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_income_expense_summary_snapshot (id, book_id, period_id, snapshot_date, income_total, expense_total, net_amount)
VALUES (900001, 900001, 900001, DATE '2026-03-31', 1000.00, 300.00, 700.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_period_close_check (id, close_id, book_id, period_id, check_code, check_name, check_result, error_count, detail_json)
VALUES (900001, NULL, 900001, 900001, 'PENDING_VOUCHER', '待审凭证检查', 'PASS', 0, '{}')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_period_reverse_close (id, book_id, period_id, reverse_no, reverse_reason, approval_status, operator_id, remark)
VALUES (900001, 900001, 900001, 'RC-202603-0001', '示例反结账', 'APPROVED', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_period_reopen_log (id, book_id, period_id, reopen_no, reason, operator_id, period_status)
VALUES (900001, 900001, 900001, 'RO-202603-0001', '示例反结账恢复', 900001, 'OPEN')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_period_operation_log (id, period_id, operation_type, operator_id, before_status, after_status, operation_desc)
VALUES (900001, 900001, 'REOPEN', 900001, 'CLOSED', 'OPEN', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_profit_transfer (id, book_id, period_id, transfer_no, transfer_date, total_amount, status, voucher_id, operator_id, remark)
VALUES (900001, 900001, 900001, 'PT-202603-0001', DATE '2026-03-31', 300.00, 'SUCCESS', 900001, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_profit_transfer_detail (id, transfer_id, line_no, from_subject_id, to_subject_id, amount, summary)
VALUES (900001, 900001, 1, 900201, 900102, 300.00, '示例结转')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_asset_category (id, category_code, category_name, depreciation_years, depreciation_method, residual_rate, enable_flag, created_by, remark)
VALUES (900001, 'ASSET_CAT_001', '电子设备', 5, 'STRAIGHT_LINE', 5.00, 1, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_asset_card (id, asset_code, asset_name, category_id, book_id, org_id, purchase_date, original_value, net_value, accumulated_depreciation, depreciation_method, depreciation_years, residual_rate, location, keeper_name, status, enable_flag, created_by, remark)
VALUES (900001, 'AST-0001', '办公电脑', 900001, 900001, 900001, DATE '2026-01-10', 5000.00, 4800.00, 200.00, 'STRAIGHT_LINE', 5, 5.00, '办公室', '张三', 'USING', 1, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_asset_depreciation (id, asset_id, book_id, period_label, depreciation_amount, accumulated_amount, net_value_after, voucher_id, created_by, remark)
VALUES (900001, 900001, 900001, '2026-03', 100.00, 300.00, 4700.00, NULL, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_asset_disposal (id, asset_id, disposal_type, disposal_date, disposal_income, disposal_loss, net_value, voucher_id, status, created_by, remark)
VALUES (900001, 900001, 'SCRAP', DATE '2026-03-25', 200.00, 50.00, 4500.00, NULL, 'NORMAL', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_asset_inventory (id, inventory_no, book_id, org_id, inventory_date, total_asset_count, actual_asset_count, diff_count, status, created_by, remark)
VALUES (900001, 'INV-202603-0001', 900001, 900001, DATE '2026-03-26', 1, 1, 0, 'DONE', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_asset_inventory_detail (id, inventory_id, asset_id, book_value, actual_value, diff_value, result_type, remark)
VALUES (900001, 900001, 900001, 4700.00, 4700.00, 0.00, 'NORMAL', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_main (id, contract_no, contract_name, contract_type, contract_amount, sign_date, start_date, end_date, counterparty_unit, counterparty_person, org_id, book_id, status, enable_flag, created_by, remark)
VALUES (900001, 'CTR-2026-0001', '示例采购合同', 'PROCUREMENT', 10000.00, DATE '2026-03-01', DATE '2026-03-01', DATE '2026-12-31', '示例供应商', '李四', 900001, 900001, 'NORMAL', 1, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_change (id, contract_id, change_type, change_date, before_amount, after_amount, change_content, voucher_id, created_by, remark)
VALUES (900001, 900001, 'AMOUNT', DATE '2026-03-10', 10000.00, 10500.00, '金额调整', NULL, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_acceptance (id, contract_id, acceptance_date, acceptance_result, acceptance_amount, acceptance_desc, operator_id, remark)
VALUES (900001, 900001, DATE '2026-03-15', 'PASS', 10500.00, '验收通过', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_termination (id, contract_id, termination_date, termination_type, termination_reason, settlement_amount, voucher_id, operator_id, remark)
VALUES (900001, 900001, DATE '2026-03-20', 'NORMAL', '示例终止', 1000.00, NULL, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_renewal (id, contract_id, renewal_no, renewal_date, renewal_start_date, renewal_end_date, renewal_amount, renewal_content, status, created_by, remark)
VALUES (900001, 900001, 'REN-2026-0001', DATE '2026-03-22', DATE '2027-01-01', DATE '2027-12-31', 11000.00, '续签一年', 'DRAFT', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_attachment (id, contract_id, biz_type, file_name, file_url, file_type, file_size, uploaded_by, remark)
VALUES (900001, 900001, 'MAIN', 'contract.pdf', '/mock/contract/900001.pdf', 'application/pdf', 1024, 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_operation_log (id, contract_id, operation_type, operation_desc, operator_id, before_json, after_json, remark)
VALUES (900001, 900001, 'CREATE', '创建合同', 900001, '{}', '{}', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_contract_payment (id, contract_id, payment_type, payment_date, amount, bank_account_id, cash_account_id, journal_id, voucher_id, status, created_by, remark)
VALUES (900001, 900001, 'RECEIPT', DATE '2026-03-18', 500.00, 900001, NULL, NULL, NULL, 'NORMAL', 900001, 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_approve_process (id, process_code, process_name, biz_type, version_no, enable_flag, remark, created_by)
VALUES (900001, 'APPROVAL_CONTRACT', '合同审批流程', 'CONTRACT', 1, 1, 'mock', 900001)
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_approve_instance (id, process_id, biz_type, biz_id, instance_no, applicant_id, current_node, approve_status, remark)
VALUES (900001, 900001, 'CONTRACT', 900001, 'INS-202603-0001', 900001, 'NODE_1', 'APPROVED', 'mock')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_approve_task (id, instance_id, task_no, node_name, approver_id, task_status, action_type, action_time, action_remark)
VALUES (900001, 900001, 'TASK-202603-0001', '一级审批', 900001, 'DONE', 'APPROVE', CURRENT_TIMESTAMP, '同意')
ON CONFLICT (id) DO NOTHING;

INSERT INTO fin_approve_history (id, instance_id, node_name, approver_id, action_type, action_result, action_time, action_remark)
VALUES (900001, 900001, '一级审批', 900001, 'APPROVE', 'PASS', CURRENT_TIMESTAMP, '同意')
ON CONFLICT (id) DO NOTHING;
