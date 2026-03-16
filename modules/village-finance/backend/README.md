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
5. 凭证、账户、日记账、内部转账、对账、月结仍待继续实现

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

