# 农经一张图模块基准文档

## 当前唯一有效基线
- 需求验收基准：`农经一张图-需求梳理.md`
- 后端接口开发基准：`农经一张图标准接口文档.md`
- 后端数据结构开发基准：`农经一张图数据结构文档.md`

## 这里的作用
- 本目录是“农经一张图”唯一有效文档收口目录。
- 当前线程涉及原型验收、接口设计、数据结构设计时，只引用本目录中的基线文件。
- 原始需求数据源仍为 `data/requirements/nongjing-map/nongjing_map_requirements.json`。

## 不要误用的目录
- 历史副本已经迁移到 `docs/archive/nongjing-map`。
- `docs/interface` 和 `docs/data` 不再保留“农经一张图”的有效基线。
- `docs/archive/nongjing-map` 下的文件只用于追溯，不再作为当前开发基线。

## 机器校验入口
- 文档注册表：`docs/doc-registry.json`
- 模块清单：`docs/modules/nongjing-map/module.manifest.json`
- 校验命令：`python scripts/validate_doc_governance.py`

## 工作习惯
1. 开发前先看本目录。
2. 不确定时先查 `module.manifest.json`。
3. 发现同名副本时，先看是否存在 `*.deprecated.json`。
