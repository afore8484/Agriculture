# 文档使用规则

## 先看这里
- 开发、联调、验收时，不要先去 `docs/interface` 或 `docs/data` 找文件。
- 先查 `docs/doc-registry.json`。
- 再查对应模块的 `docs/modules/<module>/module.manifest.json`。

## 当前规则
- `docs/nongjing-map` 是“农经一张图”的当前有效文档收口目录。
- “农经一张图”的旧副本已经迁移到 `docs/archive/nongjing-map`。
- `docs/interface` 和 `docs/data` 不再保留“农经一张图”的当前开发基线。
- 历史副本是否已废弃，以同名 `*.deprecated.json` 为准。

## 当前农经一张图唯一有效基线
- 需求：`docs/nongjing-map/农经一张图-需求梳理.md`
- 接口：`docs/nongjing-map/农经一张图标准接口文档.md`
- 数据结构：`docs/nongjing-map/农经一张图数据结构文档.md`
- 历史归档：`docs/archive/nongjing-map`

## 使用动作
1. 进入模块前，先确认 `docs/doc-registry.json`
2. 开发前，先确认 `docs/modules/nongjing-map/module.manifest.json`
3. 文档治理校验命令：`python scripts/validate_doc_governance.py`

## 约束
- 不要把旧副本重新改成“当前版本”。
- 不要在多个目录各维护一份同名基线。
- 新模块要先补 `module.manifest.json`，再开始扩写文档。
