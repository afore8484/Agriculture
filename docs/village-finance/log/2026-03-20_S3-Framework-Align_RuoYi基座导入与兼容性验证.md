# 2026-03-20 S3-Framework-Align：RuoYi基座导入与兼容性验证

## 本轮范围

1. 导入真实 `ruoyi-vue-pro`（Yudao）基础工程到项目工作区。
2. 完成 `modules/village-finance/backend` 对 RuoYi 根工程的模块挂载与父工程继承对齐。
3. 在 Java 17 环境下验证最小编译链路与最小测试链路。
4. 不新增任何业务接口与业务功能。

## 已完成事项

1. 已同步 `ruoyi-vue-pro` 真实工程目录到仓库。
2. 已确认根 `pom.xml` 包含模块挂载：`<module>../modules/village-finance/backend</module>`。
3. 已调整 `modules/village-finance/backend/pom.xml`：
   - 父工程切换为 `cn.iocoder.boot:yudao`。
   - `relativePath` 指向 `../../../ruoyi-vue-pro/pom.xml`。
   - 补齐测试依赖 `org.mockito:mockito-inline`（test scope）。
4. 已完成最小链路验证：
   - 编译：`mvn -q -pl ../modules/village-finance/backend -am -DskipTests test-compile` 通过。
   - 测试：`FinanceFoundationQueryServiceImplTest`、`FinanceFundsServiceImplTest`、`VoucherServiceImplTest` 可运行通过。

## 验证环境

1. Java：`17.0.12`
2. Maven：`3.8.3`
3. 构建入口：`ruoyi-vue-pro` 根目录

## 风险与说明

1. 当前构建方式已切换为“从 `ruoyi-vue-pro` 根目录构建”。直接在 `modules/village-finance/backend` 子目录单独执行 Maven 可能出现父 BOM 解析问题，不作为推荐入口。
2. 命令行偶发输出 `Access is denied.`，但当前命令退出码为成功（0），本轮未发现由此导致的编译或测试失败。

## 本轮未做事项

1. 未变更任何财务业务逻辑。
2. 未新增或修改数据库结构。
3. 未扩展二阶段业务模块能力。

## 下一步建议

1. 继续执行 S3-P4-A（银农直联 R1-A 查询与配置最小包），保持“最小接口 + 最小留痕 + 最小测试”。
2. 在后续每轮日志中统一记录“构建入口为 `ruoyi-vue-pro` 根目录”。
