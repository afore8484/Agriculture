#!/usr/bin/env python3
from __future__ import annotations

import json
from collections import OrderedDict, defaultdict
from pathlib import Path

INPUT_PATH = Path('data/requirements/requirements_supervision_full.json')
OUTPUT_PATH = Path('require/新型农业经营主体财务经营监管系统需求分析.md')

MERGED_MODULE_NAME = '新型农业经营主体财务经营监管系统'

REORG_ORDER = [
    '跨端首页与驾驶舱',
    '经营主体档案与目录',
    '成员账户与权益核算',
    '经营交易与进销存协同',
    '财务盈余与量化管理',
    '项目申报与示范监测',
    '金融产品与信贷协同',
    '助农服务与行情资讯',
    '政策公告与合规支持',
]

MAPPING = {
    ('主体端', '首页'): '跨端首页与驾驶舱',
    ('政府端', '首页'): '跨端首页与驾驶舱',
    ('政府端', '大屏中心'): '跨端首页与驾驶舱',
    ('金融端', '首页'): '跨端首页与驾驶舱',

    ('主体端', '经营主体管理'): '经营主体档案与目录',
    ('政府端', '经营主体目录'): '经营主体档案与目录',
    ('政府端', '经营主体管理'): '经营主体档案与目录',

    ('主体端', '成员账户管理'): '成员账户与权益核算',

    ('主体端', '商品管理'): '经营交易与进销存协同',
    ('主体端', '店铺管理'): '经营交易与进销存协同',
    ('主体端', '客户管理'): '经营交易与进销存协同',
    ('主体端', '进销存管理'): '经营交易与进销存协同',

    ('主体端', '盈余管理'): '财务盈余与量化管理',

    ('主体端', '补贴项目信息'): '项目申报与示范监测',
    ('主体端', '示范申报'): '项目申报与示范监测',
    ('主体端', '示范监测'): '项目申报与示范监测',
    ('政府端', '项目管理'): '项目申报与示范监测',
    ('政府端', '示范申报'): '项目申报与示范监测',
    ('政府端', '示范监测'): '项目申报与示范监测',

    ('主体端', '金融服务'): '金融产品与信贷协同',
    ('金融端', '金融产品'): '金融产品与信贷协同',
    ('金融端', '信贷管理'): '金融产品与信贷协同',

    ('主体端', '助农服务'): '助农服务与行情资讯',
    ('主体端', '农产品行情'): '助农服务与行情资讯',

    ('政府端', '通知公告'): '政策公告与合规支持',
    ('金融端', '政策法规'): '政策公告与合规支持',
}


def load_records() -> tuple[dict, list[dict]]:
    data = json.loads(INPUT_PATH.read_text(encoding='utf-8'))
    return data.get('meta', {}), data.get('records', [])


def main() -> None:
    meta, records = load_records()

    missing = []
    grouped: dict[str, list[dict]] = {name: [] for name in REORG_ORDER}
    map_counter: OrderedDict[tuple[str, str, str], int] = OrderedDict()

    for rec in records:
        terminal = rec.get('terminal', '')
        level2 = rec.get('level2_filled', '')
        key = (terminal, level2)
        module = MAPPING.get(key)
        if module is None:
            missing.append(key)
            continue

        grouped[module].append(rec)
        k = (terminal, level2, module)
        if k not in map_counter:
            map_counter[k] = 0
        map_counter[k] += 1

    if missing:
        unique_missing = sorted(set(missing))
        lines = ['存在未映射条目，请先补齐映射：']
        lines.extend([f'- {item[0]} / {item[1]}' for item in unique_missing])
        raise ValueError('\n'.join(lines))

    for module in REORG_ORDER:
        grouped[module].sort(key=lambda x: (x.get('row_no', 0), x.get('id', '')))

    total = sum(len(v) for v in grouped.values())

    lines: list[str] = []
    lines.append(f'# {MERGED_MODULE_NAME}需求分析')
    lines.append('')
    lines.append('## 1. 整理说明')
    lines.append('')
    lines.append('- 本文档仅对既有需求进行梳理与重组，不新增任何功能模块与功能点。')
    lines.append('- 数据来源：`data/requirements/requirements_supervision_full.json`。')
    lines.append(f"- 原始条目总数：`{len(records)}`；重组后纳入条目总数：`{total}`。")
    lines.append(f"- 模块范围：`{MERGED_MODULE_NAME}`（主体端、政府端、金融端三端整合）。")
    if meta:
        extracted_at = meta.get('extracted_at', '')
        source_path = meta.get('source_path', '')
        if extracted_at:
            lines.append(f'- 数据抽取时间：`{extracted_at}`。')
        if source_path:
            lines.append(f'- 源文档路径：`{source_path}`。')
    lines.append('')

    lines.append('## 2. 重组后二级子模块（用于执行进度）')
    lines.append('')
    lines.append('| 序号 | 二级子模块 | 条目数 | 覆盖原模块（端/原二级） |')
    lines.append('|---|---|---:|---|')
    for idx, module in enumerate(REORG_ORDER, start=1):
        items = grouped[module]
        pairs = []
        seen = set()
        for rec in items:
            pair = f"{rec.get('terminal','')}/{rec.get('level2_filled','')}"
            if pair not in seen:
                seen.add(pair)
                pairs.append(pair)
        lines.append(f"| {idx} | {module} | {len(items)} | {'；'.join(pairs)} |")
    lines.append('')

    lines.append('## 3. 原始二级模块映射表（执行跟踪基线）')
    lines.append('')
    lines.append('| 端 | 原二级模块 | 重组后二级子模块 | 条目数 |')
    lines.append('|---|---|---|---:|')
    for terminal, level2, module in map_counter.keys():
        lines.append(f"| {terminal} | {level2} | {module} | {map_counter[(terminal, level2, module)]} |")
    lines.append('')

    lines.append('## 4. 需求清单（按重组后二级子模块）')
    lines.append('')

    for module in REORG_ORDER:
        items = grouped[module]
        lines.append(f"### 4.{REORG_ORDER.index(module)+1} {module}（{len(items)}条）")
        lines.append('')
        for rec in items:
            rec_id = rec.get('id', '')
            terminal = rec.get('terminal', '')
            level2 = rec.get('level2_filled', '')
            remark = rec.get('remark_raw', '') or '（原记录备注为空）'
            row_no = rec.get('row_no', '')
            lines.append(f"- `{rec_id}`（行{row_no}，{terminal}/{level2}）：{remark}")
        lines.append('')

    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text('\n'.join(lines), encoding='utf-8')
    print(f'Output: {OUTPUT_PATH}')
    print(f'Total records: {total}')
    for module in REORG_ORDER:
        print(f'- {module}: {len(grouped[module])}')


if __name__ == '__main__':
    main()
