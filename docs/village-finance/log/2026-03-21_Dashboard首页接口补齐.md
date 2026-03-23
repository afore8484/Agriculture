# 2026-03-21 Dashboard 首页接口补齐

## 本轮范围

1. 仅补齐首页（Dashboard）后端接口，不新增业务功能。
2. 不修改前端页面组件代码，仅提供后端 API 支撑。
3. 保持既有财务口径与期间规则不变。

## 已完成

1. 新增首页接口控制器：
   - `GET /api/village-finance/home/stats`（兼容 `/api/home/stats`）
   - `GET /api/village-finance/home/todos`（兼容 `/api/home/todos`）
   - `GET /api/village-finance/home/charts`（兼容 `/api/home/charts`）
   - `GET /api/village-finance/home/asset-distribution`
   - `GET /api/village-finance/home/recent-vouchers`
   - `GET /api/village-finance/home/progress`（兼容 `/api/home/progress`）
2. 新增首页聚合服务：
   - `FinanceHomeService`
   - `FinanceHomeServiceImpl`
3. 补齐凭证列表字段：
   - `VoucherListRespVO` 新增 `summary`
   - `VoucherServiceImpl#getVouchers` 补充摘要填充逻辑（首分录摘要）
4. 新增最小测试：
   - `FinanceHomeServiceImplTest`

## 验证结果

1. 编译验证：
   - `mvn -q -pl ../modules/village-finance/backend -am -DskipTests test-compile` 通过
2. 最小测试：
   - `mvn -q -pl ../modules/village-finance/backend "-Dtest=FinanceHomeServiceImplTest,VoucherServiceImplTest" test` 通过
3. 环境告警：
   - 控制台仍出现 `Access is denied.`，但不影响 Maven 退出码与测试通过判定。

## 未完成事项

1. 首页消息通知、公告、政策资讯等接口本轮未补（本轮只补 Dashboard 当前需要的最小链路）。
2. 首页接口尚未接入前端真实调用（按基线，未收到前端组件修改命令）。

## 风险提示

1. 首页统计与趋势当前基于实时聚合，数据量增长后需结合响应SLA做性能优化。
2. 待办紧急度目前基于关键字规则推断（`紧急/URGENT/HIGH`），后续可在审批模型中固化字段以降低语义漂移。
