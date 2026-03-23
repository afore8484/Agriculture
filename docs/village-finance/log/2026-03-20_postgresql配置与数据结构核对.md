# 2026-03-20 PostgreSQL 联调配置与结构核对

## 1. 记录的数据库配置
- Host: `43.143.232.82`
- Port: `5432`
- DB: `village_finance_dev`
- User: `village_finance`
- Password: `9AsWSC4h0eq3JwfBzIpY`

## 2. 连通性核对
- 已通过 JDBC 连接成功
- 实例信息: PostgreSQL 16.11
- 当前账号: `village_finance`
- 当前数据库: `village_finance_dev`

## 3. 数据结构文档核对口径
- 文档来源: `docs/village-finance/data/数据结构文档.md`
- 采用规则: 从文档反引号标识中提取表名候选，与库中 `information_schema.tables`（排除系统 schema）进行名称级比对
- 当前库 schema: `village_finance_ops`

## 4. 比对结果（名称级）
- 文档候选表数: `106`
- 实际库表数: `36`
- 同名命中: `13`
- 文档缺失: `93`
- 文档外表: `23`

### 4.1 同名命中（13）
- `fin_bank_journal`
- `fin_book`
- `fin_cash_journal`
- `fin_period`
- `fin_period_close`
- `fin_subject`
- `fin_voucher`
- `party_member`
- `party_org`
- `pay_order`
- `sys_role`
- `sys_user`
- `sys_user_role`

### 4.2 主要缺失（节选）
- 审批: `approve_process`, `approve_instance`, `approve_task`, `approve_history`
- 合同: `contract_main`, `contract_change`, `contract_acceptance`, `contract_payment`, `contract_termination`, `contract_renewal`
- 资产: `asset_category`, `asset_card`, `asset_depreciation`, `asset_disposal`, `asset_inventory`, `asset_inventory_detail`
- 财务扩展: `fin_internal_transfer`, `fin_reconciliation`, `fin_voucher_entry`, `fin_subject_balance`, `fin_subject_category`, `fin_subject_opening`
- 报表: `rep_report_definition`, `rep_report_formula`, `rep_report_snapshot`

### 4.3 文档外（节选）
- `ast_asset_card`, `ast_asset_change_log`
- `ctr_contract`, `ctr_acceptance`, `ctr_termination`
- `fin_voucher_line`
- `rpt_balance_sheet`, `rpt_income_distribution`, `rpt_bookkeeping_progress`
- `wf_process_def`, `wf_instance`, `wf_step_def`, `wf_task`

## 5. 结论
- 当前数据库与《数据结构文档》在“表名标准化”层面存在明显偏差。
- 问题主要表现为：
  1. 设计名与落地名并存（如 `contract_*` vs `ctr_*`、`asset_*` vs `ast_*`）
  2. 部分文档目标表尚未落库
  3. 部分已落库表使用了替代命名（如 `fin_voucher_line` 对应文档 `fin_voucher_entry`）

## 6. 产物文件
- `output/db_tables.csv`
- `output/db_columns.csv`
- `output/schema_match_tables.txt`
- `output/schema_missing_tables.txt`
- `output/schema_extra_tables.txt`

## 7. 核心表字段抽查（数据库实测）

- `fin_book`：`id, book_code, book_name, org_id, org_code, fiscal_year, currency, start_date, end_date, status, remark, created_at, updated_at`
- `fin_period`：`id, book_id, period_year, period_no, start_date, end_date, close_status, close_time, created_at, updated_at`
- `fin_subject`：`id, book_id, subject_code, subject_name, parent_id, parent_code, category_id, balance_direction, level, is_leaf, enable_flag, assist_flag, remark, created_at, updated_at`
- `fin_voucher`：`voucher_id, village_id, voucher_no, voucher_date, period_month, voucher_type, source_type, total_debit, total_credit, voucher_status, created_by, approved_by, created_at, updated_at`
- `fin_voucher_line`（文档为 `fin_voucher_entry`）：`line_id, voucher_id, line_no, subject_code, subject_name, debit_amount, credit_amount, summary`
- `fin_bank_journal`：`bank_journal_id, village_id, bank_account_no, txn_date, period_month, txn_direction, txn_amount, counterparty_name, summary, voucher_id, created_by, created_at`
- `fin_cash_journal`：`cash_journal_id, village_id, txn_date, period_month, income_amount, expense_amount, balance_amount, summary, voucher_id, created_by, created_at`

字段层面说明：
- 核心主线相关表可见，但命名体系与文档存在差异（如主键命名、`village_id` 与 `ledger/book` 口径差异）。
- 凭证明细采用 `fin_voucher_line`，而文档主命名为 `fin_voucher_entry`，需要在基线中明确“等价映射”。
