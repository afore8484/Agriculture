# village-finance backend

该目录为 `村委财务事务管理系统` 后端代码预留目录。

当前用途：
1. 固定云端 Agent 的后端开发落点
2. 避免后续云端任务继续把代码、文档、原型混放
3. 为后端工程初始化预留统一入口

## 当前约束

1. 后端实现必须以以下文档为主：
   - `docs/village-finance/data/数据结构文档.md`
   - `docs/village-finance/interface/接口文档.md`
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

1. 后端工程骨架尚未建立
2. 数据库连接方式尚未落地
3. 实际运行配置尚未提供
4. Redis / MQ / 对象存储 / 外部接口依赖尚未确认

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
