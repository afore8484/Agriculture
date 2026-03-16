# 农经一张图后端

当前目录是“农经一张图”正式后端工程，作为 `RuoYi-Vue-Pro` 风格单体 Spring Boot 服务的实现落点。

## 基准文档

- 需求验收基准：`docs/nongjing-map/农经一张图-需求梳理.md`
- 接口开发基准：`docs/nongjing-map/农经一张图标准接口文档.md`
- 数据结构基准：`docs/nongjing-map/农经一张图数据结构文档.md`

## 当前技术栈

- Java 17
- Spring Boot 3
- MyBatis-Plus
- Flyway
- PostgreSQL
- SpringDoc OpenAPI

## 当前范围

当前版本优先落地以下能力：

1. 工程骨架和数据库迁移
2. 公共查询接口
3. 总览页接口
4. 财务一张图接口
5. 其余 6 个专题接口

## 启动命令

```powershell
mvn test
mvn spring-boot:run -Dspring-boot.run.profiles=dev
mvn clean package -DskipTests
```

## 当前首批接口

- `GET /api/nongjing/common/regions`
- `GET /api/nongjing/common/region-detail`
- `GET /api/nongjing/common/time-dimensions`
- `GET /api/nongjing/common/metrics`
- `GET /api/nongjing/common/dict-items`
- `GET /api/nongjing/overview/weather`
- `GET /api/nongjing/overview/cards`
- `GET /api/nongjing/overview/map-stats`