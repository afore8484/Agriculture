# Day 1 Deliverables (Nongjing One-Map)

This package bootstraps parallel work for:
- Mid-fidelity prototype design
- PostgreSQL 16 + PostGIS analytics schema (read model)

## Inputs
- Requirement source: data/requirements/nongjing-map/nongjing_map_requirements.json
- Scope: all 7 submodules under Nongjing One-Map

## Files
1. docs/day1/prototype_page_tree.md
2. docs/day1/figma_frame_spec_finance.md
3. docs/day1/metric_dictionary_finance_v0_1.csv
4. docs/day1/component_field_mapping_finance_v0_1.csv
5. sql/postgres/nongjing_analytics_v0_1.sql

## Execution order
1. Freeze metric semantics using metric_dictionary_finance_v0_1.csv.
2. Build finance prototype frames using figma_frame_spec_finance.md.
3. Create DB schema from nongjing_analytics_v0_1.sql.
4. Bind each component to table fields using component_field_mapping_finance_v0_1.csv.
5. Replicate the same workflow to the other 6 submodules.

## Day 1 acceptance
- Finance prototype frame tree is complete and clickable flow is clear.
- SQL schema applies successfully in PostgreSQL 16 with PostGIS.
- Every finance core component has mapped metric_code and source fields.

## Additional outputs (implemented)
6. docs/day1/prototype/finance_f1_f6_wireframe_zh.html
7. docs/day1/prototype/finance_metric_badge_checklist.csv

## How to use
- Open docs/day1/prototype/finance_f1_f6_wireframe_zh.html in browser.
- Recreate frames/components in Figma 1:1 based on this wireframe.
- Validate metric badge placement with finance_metric_badge_checklist.csv.

## 中文原型与操作
- 中文页面: docs/day1/prototype/finance_f1_f6_wireframe_zh.html
- 页面已移除“如何操作这个原型”区块。
- 推荐直接打开中文页面进行评审与演示。


## GIS structural decision
- GIS is implemented as a shared cross-cutting layer across F1-F6.
- No standalone F7 business page is used in the current prototype baseline.
- Legacy file finance_f1_f7_wireframe_zh.html now redirects to finance_f1_f6_wireframe_zh.html.

- 农经总览页（严格二级模块原名）: docs/day1/prototype/nongjing_one_map_modules_zh.html



