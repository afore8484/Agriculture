# village-finance backend

该目录为 `村委财务事务管理系统` 后端代码预留目录。

当前用途：
1. 固定云端 Agent 的后端开发落点
2. 避免后续云端任务继续把代码、文档、原型混放
3. 为后端工程初始化预留统一入口

## 当前约束

1. 后端实现必须以以下文档为主：
   - `docs/data/村委财务事务管理系统数据结构文档..md`
   - `docs/interface/村委财务事务管理系统-接口文档.md`
2. 开发结果必须以以下文档校验：
   - `require/village-finance/村委财务事务管理系统-需求梳理.md`
3. 前端原型工程只作为参考：
   - `modules/village-finance/frontend`

## 技术约束

1. Java 17+
2. RuoYi-Vue-Pro
3. Maven 构建
4. PostgreSQL 数据库
5. 未来兼容金仓数据库

## 默认命令

1. 依赖准备：`mvn dependency:go-offline`
2. 测试：`mvn test`
3. 构建：`mvn clean package -DskipTests`
4. 启动：`mvn spring-boot:run -Dspring-boot.run.profiles=dev`

## 当前状态

1. 已初始化 Spring Boot + Maven 后端骨架
2. 已接入 PostgreSQL + Flyway + MyBatis-Plus
3. 已落地首批基础查询接口：
   - `GET /api/village-finance/ledgers`
   - `GET /api/village-finance/periods`
   - `GET /api/village-finance/subjects/tree`
4. 已补核心基础表迁移：
   - `fin_book`
   - `fin_period`
   - `fin_subject`
5. 已落地凭证主流程与基础财务闭环接口：
   - 账户：`/accounts/cash`、`/accounts/bank`
   - 日记账：`/journals/bank`、`/journals/cash`
   - 内部转账：`/internal-transfers`
   - 对账与月结：`/reconciliations`、`/period-close/*`
6. C1 最小闭环已补齐：
   - 内部转账成功后自动调用 `createVoucher`
   - 凭证生成成功后回写 `fin_internal_transfer.voucher_id`
   - 转账入库、凭证生成、`voucher_id` 回写在同一事务内
   - 凭证生成失败时，内部转账整体失败并回滚
7. E1 测试与构建链路已修复：
   - `mvn -q -DskipTests test-compile` 可通过
   - `mvn -q test` 可通过
   - 针对 `FinanceFoundationQueryServiceImplTest`、`FinanceFundsServiceImplTest`、`VoucherServiceImplTest` 已完成最小可运行验证
8. S2-R1 维护增强已完成（不扩展模块）：
   - 账户维护补齐：修改、启用、停用、受限删除
   - 停用账户禁止新增银行/现金日记账
   - 已发生日记账或内部转账的账户禁止删除
9. S2-R2 期间边界回归已完成（不扩展模块）：
   - 凭证写入动作在 `CLOSED` 期间被拦截：新增、修改、审核、反审核
   - 银行/现金日记账新增在 `CLOSED` 期间被拦截
   - 内部转账沿用关闭期间拦截规则，反结账后恢复可写
   - 月结状态迁移边界补充测试：已结账期间禁止重复月结
10. S2-R3 凭证-资金链路一致性收口已完成（不扩展模块）：
   - 转账凭证写操作新增链路一致性校验（必须关联唯一 `SUCCESS` 内部转账）
   - 禁止删除 `TRANSFER` 凭证，避免 `voucherId` 链路断裂
   - 禁止删除已关联有效凭证的内部转账记录
11. S2-R4 账簿入口最小闭环已完成（不扩展报表中心）：
   - 新增总账最小查询：按账套、期间、科目编码（可选）查询 `opening/debit/credit/closing`
   - 新增明细账最小查询：按账套、期间、科目查询 `voucherNo/date/summary/debit/credit/balance`
   - 口径仅基于现有凭证与分录数据，且仅纳入 `AUDITED` 凭证分录
12. S2-R5 报表口径与主线规则固化已完成（文档收口）：
   - 账簿入账口径固定：仅 `AUDITED` 凭证参与统计
   - `DRAFT`、回收站/无效凭证不计入余额
   - `CLOSED` 期间允许读、不允许写
   - 当前账簿覆盖仅限总账、明细账
13. S2-R6 科目余额表 + 序时账最小闭环已完成（不扩展报表中心）：
   - 新增科目余额表最小查询（与总账同口径）
   - 新增序时账最小查询（按期间/日期范围读取凭证流水）
   - 严格复用 S2-R5 冻结口径：仅 `AUDITED` 入账，`DRAFT`/回收站/无效不入账，`CLOSED` 只读
14. S2-R7（功能包）辅助账/多栏账 + 报表中心最小链路已完成（不扩展二阶段模块）：
   - 新增辅助账最小查询（assist-balance）
   - 新增多栏账最小查询（multi-ledger）
   - 新增报表中心最小链路：进度查询（progress）→ 导出（export）→ 打印（print）
   - 全部继续复用 S2-R5 冻结口径（仅 `AUDITED` 入账）

## 首轮闭环验收收口（F1）

### 完成度结论

按 `require/village-finance/云端Agent首轮开发包.md` 的 12 项最小闭环能力核对，当前后端首轮完成度评估为 **80%~90%（建议按 85% 口径跟踪）**。

### 首轮闭环完成度对照（12 项）

1. 已完成：账套查询、会计期间查询、会计科目树查询
2. 已完成：凭证列表/详情/新增/修改/审核/反审核/删除/回收站
3. 部分完成：银行账户（已支持列表+新增；未覆盖完整维护面）
4. 部分完成：现金账户（已支持列表+新增；未覆盖完整维护面）
5. 已完成：银行日记账查询+新增
6. 已完成：现金日记账查询+新增
7. 已完成：内部转账执行与留痕，且已打通“转账 -> 凭证 -> voucherId 回写”闭环
8. 已完成：出纳对账结果生成与查询、待对账凭证查询
9. 已完成：试算、月结、反结账接口与服务链路
10. 风险项：运行环境偶发 `Access is denied.` 输出，当前不影响命令退出码
11. 风险项：首轮外大模块（报表/资产/合同/审批/银农直联/党建）未实现，属边界内预期
12. 风险项：文档中的“维护”口径可能高于当前“最小可运行”能力，需在二阶段补齐

### 当前可运行能力清单（后端）

1. 基础查询：`/ledgers`、`/periods`、`/subjects/tree`
2. 凭证主流程：`/vouchers`（含审核、反审核、回收站）
3. 资金主流程：`/accounts/*`、`/journals/*`、`/internal-transfers`
4. 对账与关账：`/reconciliations*`、`/period-close/*`
5. 可运行测试链路：`FinanceFoundationQueryServiceImplTest`、`FinanceFundsServiceImplTest`、`VoucherServiceImplTest`
6. 账户维护接口（S2-R1）：
   - `PUT /api/village-finance/bank-accounts/{accountId}`
   - `POST /api/village-finance/bank-accounts/{accountId}/enable`
   - `POST /api/village-finance/bank-accounts/{accountId}/disable`
   - `DELETE /api/village-finance/bank-accounts/{accountId}`
   - `PUT /api/village-finance/cash-accounts/{accountId}`
   - `POST /api/village-finance/cash-accounts/{accountId}/enable`
   - `POST /api/village-finance/cash-accounts/{accountId}/disable`
   - `DELETE /api/village-finance/cash-accounts/{accountId}`
7. S2-R2 边界回归测试覆盖：
   - `shouldRejectVoucherWriteWhenPeriodClosed`
   - `shouldRejectJournalWriteWhenPeriodClosed`
   - `shouldRejectTransferWhenPeriodClosed`
   - `shouldAllowWriteAfterReopenPeriod`
   - `shouldRejectInvalidMonthCloseStateTransition`
8. S2-R3 链路一致性测试覆盖：
   - `shouldKeepTransferVoucherLinkConsistent`
   - `shouldRejectInvalidVoucherLinkState`
   - `shouldKeepConsistencyAfterAuditUnaudit`
   - `shouldKeepConsistencyAfterRecycleRestore`
   - `shouldTraceBusinessSourceFromVoucher`
9. S2-R4 账簿查询接口：
   - `GET /api/village-finance/report/general-ledger`
   - `GET /api/village-finance/report/detail-ledger`
10. S2-R4 账簿最小测试覆盖：
   - `shouldQueryGeneralLedgerByLedgerPeriodSubject`
   - `shouldQueryDetailLedgerByLedgerPeriodSubject`
   - `shouldExcludeDeletedOrInvalidVoucherEntriesIfRequiredByBaseline`
   - `shouldRespectClosedPeriodReadability`
   - `shouldCalculateDebitCreditAndBalanceByBaselineRule`
11. S2-R6 账簿补齐接口：
   - `GET /api/village-finance/report/balance`（兼容 `/api/report/balance`）
   - `GET /api/village-finance/report/journal`（兼容 `/api/report/journal`）
12. S2-R6 最小测试覆盖：
   - `shouldQuerySubjectBalanceByLedgerPeriod`
   - `shouldQueryJournalLedgerByLedgerPeriodDateRange`
   - `shouldRespectAuditedOnlyRule`
   - `shouldRespectClosedPeriodReadability`
   - `shouldKeepBalanceCalculationConsistentWithGeneralLedger`
13. S2-R7（功能包）新增接口：
   - `GET /api/village-finance/report/assist-balance`（兼容 `/api/report/assist-balance`）
   - `GET /api/village-finance/report/multi-ledger`（兼容 `/api/report/multi-ledger`）
   - `GET /api/village-finance/report/progress`（兼容 `/api/report/progress`）
   - `GET /api/village-finance/report/export`（兼容 `/api/report/export`）
   - `GET /api/village-finance/report/print`（兼容 `/api/report/print`）
14. S2-R7（功能包）最小测试覆盖：
   - `shouldQueryAssistBalanceMinimal`
   - `shouldQueryMultiLedgerMinimal`
   - `shouldSupportReportCenterQueryExportPrintMinimalChain`

## S2-R5 口径固化

### 账簿/报表最小口径（当前冻结）

1. 入账统计仅纳入 `AUDITED` 凭证及其分录。
2. `DRAFT` 凭证不计入余额。
3. 回收站凭证、无效凭证不计入余额。
4. `CLOSED` 期间允许查询读取，不允许新增/修改/审核/反审核等写入动作。
5. 当前账簿能力仅覆盖：
   - 总账（General Ledger）
   - 明细账（Detail Ledger）

### 最小财务闭环（当前冻结）

1. 基础主数据查询：账套、期间、科目树。
2. 凭证主流程：新增、修改、审核、反审核、删除、回收站（含期间关闭边界约束）。
3. 资金主流程：银行/现金账户维护、银行/现金日记账、内部转账。
4. 转账-凭证联动：内部转账成功后自动生成凭证并回写 `voucherId`，事务一致。
5. 资金与凭证链路一致性：转账凭证链路校验、关键删除保护。
6. 对账与关账：对账结果生成、月结、反结账及关键状态边界回归。

### S2-R5冻结时未覆盖能力（历史）

1. 科目余额表
2. 序时账
3. 辅助账（余额/明细）
4. 多栏账
5. 报表中心完整能力（统计分析、打印、导出、快照等）

### 当前未覆盖能力（S2-R7后）

1. 辅助账明细（assist-detail）
2. 科目汇总表（subject-summary）
3. 报表中心财务三大表（资产负债表、收支表、现金流量表）及统计分析
4. 报表中心完整打印/导出服务链路（真实文件生成、模板、审计留痕）

### 已记录风险（含响应要求）

1. 当前账簿查询为实时聚合实现，尚未固化接口级响应SLA（如P95/P99时延、超时阈值）。
2. 随数据量增长，`general-ledger/detail-ledger/balance/journal` 可能出现响应退化风险。
3. 进入下一轮前建议先明确响应目标并补最小压测基线（不改口径前提下做性能收口）。

## 响应要求基线（已冻结）

### 并发基线

1. 平台按 **2000 用户并发总数**进行设计。

### 响应时间基线

1. 交互类业务（录入、修改、删除、发布等）：
   - 平均响应时间：**1 秒**
   - 峰值响应时间：**3 秒**
2. 批量前台经办业务数据导入（按一次 2000 条评估）：
   - 平均响应时间：**5 秒**
   - 峰值响应时间：**10 秒**
3. 查询类业务：
   - 简单查询平均响应时间：**1 秒**
   - 复杂查询平均响应时间：**3 秒**
   - 视频播放平均响应时间：**3 秒**
4. 交易接口服务（数据交换）：
   - 单条记录交易接口平均响应时间：**1 秒**
   - 多条记录（100 条）交易接口平均响应时间：**3 秒**

### 执行说明

1. 上述响应要求作为后续性能验证与优化的统一验收基线。
2. 在不改变 S2-R5 冻结业务口径前提下，后续优化可围绕查询链路、索引和缓存策略展开。

### 下一阶段建议顺序

1. 先补“账簿剩余入口”：辅助账明细、科目汇总表。
2. 再补“报表中心核心查询”：资产负债表、收支表、现金流量表。
3. 再补“报表中心完整导出/打印链路”与性能收口（响应SLA基线）。
4. 最后进入二阶段模块（资产、合同、审批、银农直联、党建）。

## S2阶段总结（R8冻结）

### S2完成结论

1. S2 阶段已完成“财务主线稳定化 + 账簿最小体系 + 报表最小链路”目标，可作为二阶段入口基线。
2. 当前系统已形成可运行、可回归、口径可追溯的最小闭环，不再建议在 S2 继续扩展横向功能面。

### 已完成能力（冻结）

1. 财务主线：
   - 账户维护（增改启停删受限）、日记账、内部转账、对账、月结/反结账；
   - 转账-凭证联动与 `voucherId` 回写；
   - 凭证-资金链路一致性保护（关键删除保护、写前关联校验）。
2. 账簿能力：
   - 总账、明细账、科目余额表、序时账、辅助账（最小）、多栏账（最小）。
3. 报表最小链路：
   - 查询（progress）→ 导出（export）→ 打印（print）最小链路已接通（URL返回口径）。

### 冻结口径（S2-R5）

1. 仅 `AUDITED` 入账。
2. `DRAFT` 不入账。
3. 回收站/无效凭证不入账。
4. `CLOSED` 可读不可写。

### 当前未覆盖能力

1. 辅助账明细（assist-detail）与科目汇总表（subject-summary）。
2. 报表中心三大表（资产负债表、收支表、现金流量表）及统计分析。
3. 报表导出/打印完整服务（真实文件生成、模板体系、审计留痕）。
4. 二阶段业务模块（资产、合同、审批、银农直联、党建）完整能力。

### 二阶段推荐顺序（冻结）

1. 资产管理：财务主线强相关，先建立资产卡片、折旧、资产结账闭环。
2. 合同管理：与资金收付、凭证联动关系紧密，次序靠前可降低接口返工。
3. 审批流：在资产/合同基础上统一单据流程，避免流程先行导致的状态回滚复杂度。
4. 银农直联：依赖审批与合同/资金规则稳定后接入更稳妥。
5. 党建模块：与财务核算主链路耦合最低，放在最后并行推进风险最小。

## 后续建议目录

在真正开始后端开发后，建议至少包含：

```text
modules/village-finance/backend/
  src/
  tests/
  migrations/
  docs/
  .env.example
  README.md
```

## S3-P0 统一“业务来源 -> 凭证关联模型”

### 本轮目标

1. 建立二阶段通用的“业务来源 -> 凭证”统一关联方式。
2. 内部转账改为复用统一服务层制证入口，不再模块内直接调用 `createVoucher`。
3. 保持 S2 冻结口径与期间边界规则不变。

### 本轮落地

1. 数据库：
   - 新增 Flyway：`V5__voucher_biz_link.sql`。
   - `fin_voucher` 新增 `biz_id`。
   - 新增索引：`idx_fin_voucher_type_biz(voucher_type, biz_id)`。
   - `fin_voucher_recycle` 同步新增 `biz_id`，保证回收站还原后来源可追溯。
2. 统一服务：
   - 新增 `BizVoucherLinkService` + `BizVoucherLinkServiceImpl`。
   - 新增标准命令对象：`BizVoucherCreateCmd`。
   - 新增追溯查询对象：`BizVoucherTraceRespVO`。
   - 提供统一方法：
     - `createVoucher(...)`
     - `traceByVoucherId(voucherId)`
     - `queryVoucherByBiz(voucherType, bizId)`
3. 来源规则：
   - 新增 `FinanceVoucherType` 常量类，统一受管来源类型。
   - 受管类型（如 `TRANSFER`）必须带 `bizId`。
   - `MANUAL` 凭证禁止绑定 `bizId`。
4. 资金链路接管：
   - `FinanceFundsServiceImpl#createTransferVoucher` 改为调用 `BizVoucherLinkService#createVoucher`。
   - 内部转账仍保持同事务：转账入库 + 凭证生成 + `voucherId` 回写。
5. 一致性增强：
   - `VoucherServiceImpl` 的转账凭证一致性校验由“仅按 `voucherId`”升级为“`voucher_type + biz_id` + 业务主表反查”。
   - 回收站删除/还原链路保留 `bizId`，避免来源丢失。

### 本轮测试

1. 新增测试：`BizVoucherLinkServiceImplTest`
   - `shouldCreateVoucherViaUnifiedLinkService`
   - `shouldTraceBusinessSourceFromVoucherTypeAndBizId`
   - `shouldRejectBypassVoucherWriteInModuleService`
2. 回归测试：
   - `FinanceFundsServiceImplTest`
   - `VoucherServiceImplTest`
3. 命令结果：
   - `mvn -q -DskipTests test-compile` 通过。
   - `mvn -q "-Dtest=BizVoucherLinkServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest" test` 通过。
   - `mvn -q test` 通过。

### 未做事项

1. 仅完成 P0 统一模型；资产/合同/审批/银农直联/党建的金额场景接入尚未展开。
2. 统一“凭证来源反查接口”当前落在服务层，控制器接口暂未开放。

## S3-P1-A 资产管理 R1-A（最小管理包）

### 本轮范围

1. 资产分类最小管理：新增、修改、查询、受限删除。
2. 资产卡片最小管理：新增、修改、详情、列表、受限删除。
3. 不实现折旧、处置、盘点、资产结账/反结账、自动制证。

### 数据落地

1. 新增 Flyway：`V6__asset_r1a_minimal.sql`。
2. 本轮核心表：
   - `fin_asset_category`
   - `fin_asset_card`
3. 为删除保护最小落地关联表（仅用于校验引用，不展开业务）：
   - `fin_asset_depreciation`
   - `fin_asset_disposal`
   - `fin_asset_inventory`
   - `fin_asset_inventory_detail`

### 接口落地

控制器：`AssetController`，同时兼容以下前缀：
- `/api/village-finance/asset`
- `/api/asset`

接口：
1. `POST /category/create`
2. `PUT /category/update`
3. `GET /category/list`
4. `DELETE /category/delete`
5. `POST /card/create`
6. `PUT /card/update`
7. `GET /card/detail`
8. `GET /card/page`
9. `DELETE /card/delete`

### 删除保护规则

1. 分类删除保护：
   - 若存在 `fin_asset_card.category_id = categoryId`，拒绝删除。
2. 资产卡片删除保护：
   - 若资产已发生折旧（`fin_asset_depreciation`），拒绝删除；
   - 若资产已发生处置（`fin_asset_disposal`），拒绝删除；
   - 若资产已发生盘点明细（`fin_asset_inventory_detail`），拒绝删除；
   - 若资产已按统一模型关联凭证（`fin_voucher.voucher_type in ASSET_* 且 biz_id=assetId`），拒绝删除。

### 最小测试

1. `shouldCreateAssetCategory`
2. `shouldRejectDeleteCategoryWhenAssetExists`
3. `shouldCreateAssetCard`
4. `shouldUpdateAssetCard`
5. `shouldRejectDeleteAssetWhenProtected`
6. `shouldQueryAssetCardList`

### 验证结果

1. `mvn -q -DskipTests test-compile`：通过。
2. `mvn -q "-Dtest=FinanceAssetServiceImplTest,FinanceFoundationQueryServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest,BizVoucherLinkServiceImplTest" test`：通过。
3. `mvn -q test`：通过。

### 未做事项

1. 未实现资产折旧、处置、盘点业务处理与流程状态。
2. 未实现资产结账/反结账。
3. 未实现资产业务自动制证。
4. 未实现导出、打印、二维码、附件体系等增强能力。

## S3-P1-B 资产管理 R1-B（折旧/处置/盘点最小业务包）

### 本轮范围

1. 资产折旧：新增 + 查询（最小校验：资产存在、期间可写、状态允许）。
2. 资产处置：新增 + 查询（最小校验：资产存在、未重复处置、期间可写）。
3. 资产盘点：盘点单新增、盘点明细新增、盘点结果查询（最小校验：资产存在、期间可写）。
4. 保持与 S3-P1-A 删除保护规则一致。
5. 明确不实现：资产结账/反结账、资产业务自动制证、复杂导出打印附件。

### 数据与迁移

1. 本轮复用 `V6__asset_r1a_minimal.sql` 已建资产业务表结构：
   - `fin_asset_depreciation`
   - `fin_asset_disposal`
   - `fin_asset_inventory`
   - `fin_asset_inventory_detail`
2. 表结构满足最小业务落地，本轮未新增 Flyway。

### 接口落地

控制器：`AssetController`，继续兼容：
- `/api/village-finance/asset`
- `/api/asset`

新增接口：
1. `POST /depreciation/create`
2. `GET /depreciation/list`
3. `POST /disposal/create`
4. `GET /disposal/list`
5. `POST /inventory/create`
6. `POST /inventory/detail/create`
7. `GET /inventory/list`
8. `GET /inventory/result`

### 状态与删除保护

1. 折旧写入前校验：
   - 资产卡片存在且启用；
   - 资产状态不是 `DISPOSED`；
   - `periodLabel` 对应期间存在且未关闭（`CLOSED` 拒绝写入）。
2. 处置写入前校验：
   - 资产卡片存在；
   - 资产未发生过处置记录（防重复）；
   - 业务日期所在期间未关闭。
3. 盘点写入前校验：
   - 盘点单日期所在期间未关闭；
   - 盘点明细中的资产存在，且资产账套与盘点账套一致。
4. 删除保护保持 S3-P1-A 规则：
   - 折旧/处置/盘点明细存在即拒绝删除资产卡片。

### 最小测试

`FinanceAssetServiceImplTest` 新增/覆盖：
1. `shouldCreateAssetDepreciation`
2. `shouldRejectDepreciationWhenPeriodClosed`
3. `shouldCreateAssetDisposal`
4. `shouldRejectDuplicateAssetDisposal`
5. `shouldCreateAssetInventoryAndDetails`
6. `shouldRejectDeleteAssetWhenBusinessExists`

### 验证结果

1. `mvn -q -DskipTests test-compile`：通过。
2. `mvn -q "-Dtest=FinanceAssetServiceImplTest" test`：通过（12/12）。
3. `mvn -q "-Dtest=FinanceAssetServiceImplTest,FinanceFoundationQueryServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest,BizVoucherLinkServiceImplTest" test`：通过。

### 未做事项

1. 未实现资产结账/反结账。
2. 未实现资产业务自动制证（统一来源模型保持待接入状态）。
3. 未实现复杂折旧规则引擎、审批流、导出/打印/附件能力。

## S3-P1-C 资产管理 R1-C（资产业务财务联动 + 资产结账/反结账）

### 本轮范围
1. 资产折旧、资产处置接入统一业务来源凭证关联模型。
2. 新增资产结账/反结账最小闭环。
3. 保持现有期间 `OPEN/CLOSED` 语义不变，仅叠加资产侧写入约束。

### 资产业务与凭证联动
1. 折旧：
   - 折旧记录入库后，调用 `BizVoucherLinkService#createVoucher` 生成凭证。
   - 凭证来源：`voucherType=ASSET_DEPRECIATION`，`bizId=depreciationId`。
   - 折旧表 `voucher_id` 回写凭证ID。
2. 处置：
   - 处置记录入库后，调用统一服务生成凭证。
   - 凭证来源：`voucherType=ASSET_DISPOSAL`，`bizId=disposalId`。
   - 处置表 `voucher_id` 回写凭证ID。
3. 科目与金额最小规则：
   - 由折旧/处置请求显式传入 `debitSubjectId`、`creditSubjectId`（处置额外传入 `voucherAmount`）；
   - 服务层校验科目存在、启用、账套一致；
   - 自动组装借贷两条分录，保证借贷平衡。
4. 事务边界：
   - 折旧：业务入库 + 制证 + `voucherId` 回写 + 资产卡片金额更新在同一事务。
   - 处置：业务入库 + 制证 + `voucherId` 回写 + 资产卡片状态更新在同一事务。

### 资产结账/反结账规则
1. 新增资产结账接口：
   - `POST /api/village-finance/asset/period-close/close`（兼容 `/api/asset/...`）
2. 新增资产反结账接口：
   - `POST /api/village-finance/asset/period-close/reopen`（兼容 `/api/asset/...`）
3. 落地策略：
   - 复用现有 `fin_period_close`，以 `close_type=ASSET` 标识资产侧结账；
   - 复用现有 `fin_period_reopen_log` 记录资产反结账，`reopen_no` 使用 `ASSET-REOPEN-*` 前缀；
   - 通过“最近资产结账时间 vs 最近资产反结账时间”判定资产期间是否关闭。
4. 写入拦截：
   - 折旧、处置、盘点、盘点明细写入路径统一走“期间可写 + 资产期间可写”双重校验；
   - 资产期间关闭后，以上写入动作拒绝；
   - 资产反结账后，恢复可写。

### 数据结构变更
1. 本轮无新增 Flyway。
2. 复用既有表结构实现：
   - `fin_asset_depreciation` / `fin_asset_disposal` 的 `voucher_id` 回写；
   - `fin_period_close(close_type)`、`fin_period_reopen_log(reopen_no)` 记录资产侧结账状态。

### 最小测试（S3-P1-C）
`FinanceAssetServiceImplTest`：
1. `shouldCreateDepreciationAndLinkVoucher`
2. `shouldCreateDisposalAndLinkVoucher`
3. `shouldRejectAssetWriteWhenAssetPeriodClosed`
4. `shouldAllowAssetWriteAfterAssetPeriodReopen`
5. `shouldKeepBizVoucherLinkConsistentForAsset`
6. `shouldRejectDeleteAssetWhenVoucherLinked`

### 验证结果
1. `mvn -q -DskipTests test-compile`：通过。
2. `mvn -q "-Dtest=FinanceAssetServiceImplTest" test`：通过（6/6）。
3. `mvn -q "-Dtest=FinanceAssetServiceImplTest,FinanceFoundationQueryServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest,BizVoucherLinkServiceImplTest" test`：通过。

### 未做事项
1. 未引入资产自动制证模板引擎（仅保留最小借贷入参制证）。
2. 未扩展资产导出、打印、附件体系。
3. 未扩展合同、审批、银农直联、党建等二阶段其他模块。

## S3-P2-A 合同管理 R1-A（合同最小管理包）

### 本轮范围
1. 合同主档：新增、修改、分页查询、详情、删除（受限，逻辑删除）。
2. 合同变更：新增、列表查询。
3. 合同验收：新增、列表查询。
4. 合同终止/续签：新增、列表查询。
5. 附件与操作日志：附件上传与列表、操作日志列表最小留痕。
6. 不展开审批联动、收付款、资金/凭证联动。

### 数据与表结构
1. 复用 `V7__contract_r1a_minimal.sql`，无新增 Flyway。
2. 使用表：
   - `fin_contract_main`
   - `fin_contract_change`
   - `fin_contract_acceptance`
   - `fin_contract_termination`
   - `fin_contract_renewal`
   - `fin_contract_attachment`
   - `fin_contract_operation_log`

### 接口落地
控制器：`ContractController`，兼容：
- `/api/village-finance/contracts`
- `/api/contract`

最小接口：
1. 主档：
   - `GET /contracts`、`GET /contracts/page`
   - `POST /contracts`、`POST /contracts/create`
   - `PUT /contracts/update`
   - `GET /contracts/detail`、`GET /contracts/{contractId}`
   - `DELETE /contracts/delete`
2. 生命周期：
   - `POST /contracts/change`、`GET /contracts/change/list`
   - `POST /contracts/accept`、`GET /contracts/accept/list`
   - `POST /contracts/terminate`、`GET /contracts/terminate/list`
   - `POST /contracts/renew`、`GET /contracts/renew/list`
3. 附件与日志：
   - `POST /contracts/attachment/upload`
   - `GET /contracts/attachment/list`
   - `GET /contracts/operation-log/list`

### 关键规则
1. 合同编号唯一；合同金额、变更金额、验收金额、结算金额、续签金额均要求非负。
2. 主档删除保护：
   - 存在变更/验收/终止/续签/附件记录时拒绝删除。
   - 删除采用逻辑删除：`status=DELETED`、`enableFlag=0`。
3. 操作留痕：
   - 主档新增/修改/删除、变更、验收、终止、续签、附件上传均写入 `fin_contract_operation_log`。
4. 状态最小联动：
   - 验收结果为 `PASS` 时主档置 `COMPLETED`。
   - 终止后主档置 `TERMINATED` 并回写 `endDate`。
   - 续签后主档恢复 `NORMAL` 并按续签金额/截止日期更新。

### 最小测试
`FinanceContractServiceImplTest`：
1. `shouldCreateContractMain`
2. `shouldRejectDeleteContractWhenBusinessExists`
3. `shouldCreateContractChange`
4. `shouldCreateContractAcceptance`
5. `shouldCreateContractTermination`
6. `shouldCreateContractRenewal`
7. `shouldUploadAttachmentAndLog`

### 验证结果
1. `mvn -q -DskipTests test-compile`：通过。
2. `mvn -q "-Dtest=FinanceContractServiceImplTest" test`：通过。
3. `mvn -q "-Dtest=FinanceContractServiceImplTest,FinanceAssetServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest,BizVoucherLinkServiceImplTest" test`：通过。
4. 环境仍有 `Access is denied.` 噪声输出，不影响命令退出码与结果判定。

### 未做事项
1. 未实现合同收付款。
2. 未实现合同与资金/凭证联动。
3. 未实现合同审批流联动与复杂附件体系（预览、版本、权限）。

## S3-P2-B 合同管理 R1-B（合同收付款 + 合同到资金/凭证联动）

### 本轮范围
1. 合同收款：新增 + 查询，最小校验（合同存在、状态允许、金额合法、期间可写）。
2. 合同付款：新增 + 查询，最小校验（合同存在、状态允许、金额合法、期间可写）。
3. 财务联动：收付款成功后，关联资金日记账与凭证，业务表回写 `journal_id`、`voucher_id`。
4. 删除保护增强：合同存在收付款记录（含已关联凭证）时，禁止删除。

### 数据与表结构
1. 新增 Flyway：`V8__contract_payment_r1b.sql`。
2. 新增表：
   - `fin_contract_payment`
3. 关键字段：
   - `payment_type`（`RECEIPT`/`PAYMENT`）
   - `bank_account_id` / `cash_account_id`
   - `journal_id`
   - `voucher_id`
4. 新增索引：
   - `idx_fin_contract_payment_contract`
   - `idx_fin_contract_payment_type_date`
   - `idx_fin_contract_payment_voucher`
   - `idx_fin_contract_payment_journal`

### 接口落地
控制器：`ContractController`，继续兼容：
- `/api/village-finance/contracts`
- `/api/contract`

新增接口：
1. `POST /contracts/receipt`：新增合同收款。
2. `POST /contracts/pay`：新增合同付款。
3. `GET /contracts/payment/list`：查询合同收付款记录（可按 `paymentType` 过滤）。
4. `GET /contracts/{contractId}/payments`：兼容接口文档中的路径查询。

### 合同与资金/凭证联动规则
1. 账户选择：`bankAccountId` 与 `cashAccountId` 必须且仅能传一个。
2. 资金联动：
   - 收款：生成 `INCOME` 日记账；
   - 付款：生成 `EXPENSE` 日记账；
   - 复用 `FinanceFundsService` 既有能力更新账户余额与期间写入校验。
3. 凭证联动：
   - 收款使用 `voucherType=CONTRACT_RECEIPT`，付款使用 `voucherType=CONTRACT_PAYMENT`；
   - 统一调用 `BizVoucherLinkService#createVoucher`，`bizId=contractPaymentId`；
   - 收付款记录回写 `voucher_id`，日记账回写 `biz_type/biz_id`。
4. 分录最小规则：
   - 收款：借 资金账户科目、贷 对方科目；
   - 付款：借 对方科目、贷 资金账户科目；
   - 金额均为收付款金额，借贷平衡由凭证服务统一校验。

### 事务与边界
1. 同一事务内执行：`fin_contract_payment` 入库 -> 日记账生成 -> 凭证生成 -> `journal_id/voucher_id` 回写。
2. 若任一环节失败（含凭证生成失败），整笔合同收付款回滚。
3. 会计期间 `CLOSED` 时，合同收付款写入被拦截。

### 最小测试（S3-P2-B）
`FinanceContractServiceImplTest` 新增/覆盖：
1. `shouldCreateContractReceipt`
2. `shouldCreateContractPayment`
3. `shouldLinkContractReceiptVoucher`
4. `shouldLinkContractPaymentVoucher`
5. `shouldRejectContractWriteWhenPeriodClosed`
6. `shouldRejectDeleteContractWhenVoucherLinked`

### 验证结果
1. `mvn -q -DskipTests test-compile`：通过。
2. `mvn -q "-Dtest=FinanceContractServiceImplTest" test`：通过（13/13）。
3. `mvn -q "-Dtest=FinanceContractServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest,BizVoucherLinkServiceImplTest" test`：通过。
4. 环境仍有 `Access is denied.` 噪声输出，不影响命令退出码与结果判定。

### 未做事项
1. 未实现合同审批联动。
2. 未扩展复杂合同状态机与复杂附件能力。
3. 未扩展银农直联与二阶段其他模块。

## S3-P3-A 在线审批 R1-A（最小流程包）

### 本轮范围
1. 流程定义最小能力：新增、修改、查询、启用、停用。
2. 流程实例最小能力：发起、详情、列表。
3. 审批任务最小能力：待办、已办、处理（通过/驳回）。
4. 审批历史最小能力：节点历史、操作留痕查询。
5. 本轮不接合同/支付/财务状态联动，不改变现有业务状态语义。

### 数据与表结构
1. 新增 Flyway：`V9__approval_r1a_minimal.sql`。
2. 新增表：
   - `fin_approve_process`
   - `fin_approve_instance`
   - `fin_approve_task`
   - `fin_approve_history`
3. 关键口径：
   - 流程实例采用最小单节点流转；
   - 任务处理后直接收敛为 `APPROVED` 或 `REJECTED`。

### 接口落地
控制器：`ApprovalController`，兼容：
- `/api/village-finance/approvals`
- `/api/approval`

最小接口：
1. 流程定义：
   - `POST /process-definitions`
   - `PUT /process-definitions/{processId}`
   - `GET /process-definitions`
   - `POST /process-definitions/{processId}/enable`
   - `POST /process-definitions/{processId}/disable`
2. 流程实例：
   - `POST /instances/start`
   - `GET /instances/{instanceId}`
   - `GET /instances`
3. 任务：
   - `GET /tasks/todo`
   - `GET /tasks/done`
   - `POST /tasks/{taskId}/actions`
4. 历史：
   - `GET /instances/{instanceId}/history`

### 审批状态与流转
1. 流程定义启停：`enable_flag` 控制可发起性。
2. 实例状态：
   - 发起后：`DRAFT -> PROCESSING`
   - 处理通过：`PROCESSING -> APPROVED`
   - 处理驳回：`PROCESSING -> REJECTED`
3. 任务状态：
   - 创建：`PENDING`
   - 处理后：`DONE`
4. 历史留痕：
   - 发起写入 `SUBMIT` 历史；
   - 审批动作写入 `APPROVE` 或 `REJECT` 历史。

### 最小测试（S3-P3-A）
`FinanceApprovalServiceImplTest`：
1. `shouldCreateProcessDefinition`
2. `shouldStartProcessInstance`
3. `shouldQueryTodoTasks`
4. `shouldApproveTask`
5. `shouldRejectTask`
6. `shouldQueryProcessHistory`

### 验证结果
1. `mvn -q -DskipTests test-compile`：通过。
2. `mvn -q "-Dtest=FinanceApprovalServiceImplTest" test`：通过（6/6）。
3. `mvn -q "-Dtest=FinanceApprovalServiceImplTest,FinanceContractServiceImplTest,FinanceFundsServiceImplTest,VoucherServiceImplTest" test`：通过。
4. 环境仍有 `Access is denied.` 噪声输出，不影响命令退出码与结果判定。

### 未做事项
1. 未接合同/支付/财务自动联动。
2. 未实现并行网关、会签、加签、抄送等复杂流程能力。
3. 未接消息通知中心与完整通知体系。

