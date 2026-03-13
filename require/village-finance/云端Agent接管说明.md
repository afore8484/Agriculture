# 村委财务事务管理系统云端 Agent 接管说明

## 1. 接管目标

当前目标为：
- 模块：`village-finance`
- 任务类型：云端持续开发
- 开发重点：后端开发
- 主依据：数据结构文档、接口文档
- 校验依据：需求梳理文档

说明：
- 前端原型工程仅作页面参考，不作为后端主依据。
- 云端 Agent 不应依赖本机路径、浏览器登录态或本地数据库。

## 2. 当前仓库基线

仓库地址：
- `https://github.com/afore8484/Agriculture.git`

默认分支：
- `main`

当前目标模块目录：
- `modules/village-finance`

当前后端预留目录：
- `modules/village-finance/backend`

## 3. 正式开发依据

### 3.1 主依据
1. `docs/village-finance/data/数据结构文档.md`
2. `docs/village-finance/interface/接口文档.md`

### 3.2 验收依据
1. `require/village-finance/村委财务事务管理系统-需求梳理.md`

### 3.3 开发任务依据
1. `require/village-finance/村委财务事务管理系统后台开发任务清单.md`
2. `require/village-finance/云端Agent首轮开发包.md`

## 4. 技术与环境契约

### 4.1 技术栈
1. Java 17+
2. RuoYi-Vue-Pro
3. Spring Boot 技术体系
4. Maven 构建体系

### 4.2 数据库约束
1. 当前数据库：PostgreSQL
2. 未来目标：兼容金仓数据库
3. 设计要求：优先使用 PostgreSQL 与金仓通用语法，不依赖高风险专有扩展

### 4.3 默认命令
在后端工程建立后，默认命令采用：
1. 依赖准备：`mvn dependency:go-offline`
2. 测试：`mvn test`
3. 构建：`mvn clean package -DskipTests`
4. 启动：`mvn spring-boot:run -Dspring-boot.run.profiles=dev`

说明：
- 若后续落地为多模块 Maven 工程，再补充具体启动模块。
- 若接入 `mvnw`，优先使用 `mvnw.cmd` 代替系统 Maven。

## 5. 云端 Agent 运行约束

1. 不允许以原型替代正式数据结构和接口文档。
2. 不允许新增需求。
3. 不允许跳过需求梳理中的既有能力。
4. 不允许依赖 `E:\...` 本机路径。
5. 不允许依赖 `127.0.0.1` 本机服务。
6. 不允许在未明确环境契约前自行假设数据库连接。
7. 数据库设计、SQL、方言使用必须考虑未来金仓兼容。

## 6. 当前已确认项

1. 模块固定为 `village-finance`。
2. 单仓结构继续使用，不拆独立仓库。
3. 后端代码目录固定为 `modules/village-finance/backend`。
4. 第一轮开发范围固定为财务主线最小闭环。
5. 后端技术栈固定为 `Java 17+ + RuoYi-Vue-Pro`。
6. 当前数据库固定为 PostgreSQL，未来需兼容金仓数据库。
7. 默认构建、测试、启动命令已固定为 Maven 体系。

## 7. 当前待补齐项

以下项目仍需在真正进入云端长时开发前补齐：

1. 后端工程骨架
2. 实际数据库连接信息
3. 是否依赖 Redis / MQ / 对象存储 / 外部接口
4. 环境变量实际值来源
5. 多模块工程的实际启动模块名

## 8. 云端 Agent 的工作方式

推荐采用“任务包推进”模式，而不是无限制连续改动。

执行规则：
1. 每轮只处理一个明确开发包。
2. 每轮都输出变更说明、验证结果、遗留问题。
3. 每轮都要回到三份正式文档校验，不直接跟随原型偏移。
4. 如环境缺失导致无法继续，先输出阻塞项，不自行编造环境。
