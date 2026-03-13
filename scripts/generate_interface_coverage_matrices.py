from __future__ import annotations

import json
import re
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import List, Tuple

BASE = Path(r'E:/workspaces/Agriculture/prototype')
OUT_DOCS = BASE / 'docs'
OUT_DATA = BASE / 'data' / 'interfaces'
OUT_DOCS.mkdir(parents=True, exist_ok=True)
OUT_DATA.mkdir(parents=True, exist_ok=True)

MODULES = [
    {
        'key': 'nongjing',
        'name': '农经一张图',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/1.农经一张图/农经一张图-需求梳理.md'),
        'schema': Path(r'F:/待办/2026/三农金融/4.原型图/1.农经一张图/农经一张图数据结构文档.md'),
        'interface': BASE / 'docs' / 'interface_detail_nongjing.md',
    },
    {
        'key': 'village_finance',
        'name': '村委财务事务管理系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/2.村委财务事务管理系统/村委财务事务管理系统-需求梳理.md'),
        'schema': Path(r'F:/待办/2026/三农金融/4.原型图/2.村委财务事务管理系统/村委财务事务管理系统.md'),
        'interface': BASE / 'docs' / 'interface_detail_village_finance.md',
    },
    {
        'key': 'income_ledger',
        'name': '村集体经济收入台账',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/3.村集体经济收入台账/村集体经济收入台账-需求梳理.md'),
        'schema': Path(r'F:/待办/2026/三农金融/4.原型图/3.村集体经济收入台账/村集体经济收入台账数据结构文档.md'),
        'interface': BASE / 'docs' / 'interface_detail_income_ledger.md',
    },
    {
        'key': 'performance',
        'name': '村集体绩效评价管理系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/4.村集体绩效评价管理系统/村集体绩效评价管理系统-需求梳理.md'),
        'schema': Path(r'F:/待办/2026/三农金融/4.原型图/4.村集体绩效评价管理系统/村集体绩效评价管理系统数据结构文档.md'),
        'interface': BASE / 'docs' / 'interface_detail_performance.md',
    },
    {
        'key': 'audit',
        'name': '村集体智能审计系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/5.村集体智能审计系统/村集体智能审计系统-需求梳理.md'),
        'schema': Path(r'F:/待办/2026/三农金融/4.原型图/5.村集体智能审计系统/村集体智能审计系统数据结构文档.md'),
        'interface': BASE / 'docs' / 'interface_detail_audit.md',
    },
    {
        'key': 'entity_supervision',
        'name': '新型农业经营主体财务经营监管系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/6.新型农业经营主体财务经营监管系统/新型农业经营主体财务经营监管系统-三端-需求梳理.md'),
        'schema': Path(r'F:/待办/2026/三农金融/4.原型图/6.新型农业经营主体财务经营监管系统/新型农业经营主体财务经营监管系统数据结构文档.md'),
        'interface': BASE / 'docs' / 'interface_detail_entity_supervision.md',
    },
]

ACTION_RULES = {
    '查询': ['查询', '获取', '查看', '展示', '显示', '呈现', '统计', '汇总', '分析', '监控', '定位', '了解'],
    '保存': ['新增', '创建', '录入', '填写', '编辑', '修改', '维护', '设置', '配置', '保存'],
    '删除': ['删除', '移除', '彻底删除'],
    '导出': ['导出', '下载模板', '下载'],
    '上传': ['上传', '导入'],
    '审核审批': ['审核', '审批', '复核', '评审'],
    '提交上报': ['提交', '上报', '发布', '申请', '填报'],
    '处置流转': ['处理', '处置', '退回', '还原', '结账', '反结账', '放款', '还款', '催收', '启用', '关闭'],
}

GENERIC_TOKENS = {
    '接口', '功能', '管理', '信息', '数据', '详情', '列表', '明细', '结果', '情况', '模块', '系统', '用户',
    '支持', '相关', '查询', '获取', '查看', '展示', '显示', '呈现', '统计', '分析', '新增', '保存', '修改',
    '删除', '导出', '上传', '下载', '功能点', '管理系统', '接口文档', '处理', '记录', '配置', '规则', '列表查询',
    '页面', '状态', '内容', '能力', '维护', '操作', '提供', '用于', '完成', '实现', '通过', '允许', '帮助', '进行',
    '当前', '对应', '快速', '方便', '相关信息', '具体信息', '详细信息', '详细数据', '综合管理', '一张图', '图统计'
}

FRONTEND_PATTERNS = [
    ('显示当前的日期和具体时间', '前端本地时间展示'),
    ('准确显示当前的日期和具体时间', '前端本地时间展示'),
]

CHINESE_SEQ_RE = re.compile(r'[\u4e00-\u9fffA-Za-z0-9_]+')
REQ_ITEM_RE = re.compile(r'^(\d+)\.\s*(.+)$')
TABLE_HEADING_RE_1 = re.compile(r'^##\s*\d+\.\s*([A-Za-z0-9_]+)\b')
TABLE_HEADING_RE_2 = re.compile(r'^(?:\*\*表：|###\s*表：)\s*`?([A-Za-z0-9_]+)`?')
BACKTICK_RE = re.compile(r'`([A-Za-z0-9_]+)`')

def read_text_auto(path: Path) -> str:
    for enc in ('utf-8-sig', 'utf-16', 'gb18030', 'utf-8'):
        try:
            return path.read_text(encoding=enc)
        except UnicodeDecodeError:
            continue
    return path.read_text(encoding='utf-8', errors='ignore')


@dataclass
class InterfaceRow:
    module: str
    name: str
    method: str
    url: str
    purpose: str
    payload: str
    sources: str
    keywords: set
    actions: set


def detect_actions(text: str) -> set:
    actions = set()
    for action, patterns in ACTION_RULES.items():
        if any(p in text for p in patterns):
            actions.add(action)
    return actions


def cleanup_token(token: str) -> str:
    token = token.strip().lower()
    for old in ['（第二版）', '（第一批）', '（第一版）', '（第五版）', '（第四版）']:
        token = token.replace(old, '')
    for old in ['（', '）', '列表', '明细', '详情', '统计', '数据', '信息', '结果', '情况', '配置', '管理', '功能', '接口', '表', '记录', '主档', '主表']:
        token = token.replace(old, '')
    for old in ['查询', '获取', '查看', '展示', '显示', '呈现', '新增', '保存', '修改', '删除', '导出', '上传', '下载']:
        token = token.replace(old, '')
    token = token.strip('_- /')
    return token


def extract_keywords(*texts: str) -> set:
    keywords = set()
    for text in texts:
        if not text:
            continue
        for token in CHINESE_SEQ_RE.findall(text):
            if len(token) < 2:
                continue
            cleaned = cleanup_token(token)
            if len(cleaned) >= 2 and cleaned not in GENERIC_TOKENS:
                keywords.add(cleaned)
                if 2 <= len(cleaned) <= 6:
                    for n in range(2, min(5, len(cleaned)) + 1):
                        for i in range(0, len(cleaned) - n + 1):
                            sub = cleaned[i:i+n]
                            if sub not in GENERIC_TOKENS:
                                keywords.add(sub)
    return {k for k in keywords if len(k) >= 2}


def parse_interface_rows(path: Path, module_name: str) -> List[InterfaceRow]:
    rows = []
    text = read_text_auto(path)
    for line in text.splitlines():
        if not line.startswith('|') or '---' in line or '接口名称' in line:
            continue
        parts = [p.strip() for p in line.strip().strip('|').split('|')]
        if len(parts) != 6:
            continue
        name, method, url, purpose, payload, sources = parts
        rows.append(InterfaceRow(
            module=module_name,
            name=name,
            method=method,
            url=url,
            purpose=purpose,
            payload=payload,
            sources=sources,
            keywords=extract_keywords(name, purpose, sources, url),
            actions=detect_actions(name + purpose)
        ))
    return rows


def parse_requirement_items(path: Path) -> List[dict]:
    items = []
    section = '未分组'
    text = read_text_auto(path)
    for line in text.splitlines():
        s = line.strip()
        if s.startswith('## '):
            title = s[3:].strip()
            if title not in {'文档说明', '模块总览', '通用规则（从原需求抽取）'}:
                section = title
            continue
        m = REQ_ITEM_RE.match(s)
        if m:
            no, text = m.groups()
            items.append({'section': section, 'item_no': int(no), 'text': text})
    return items


def parse_schema_objects(path: Path) -> Tuple[List[dict], List[dict]]:
    text = read_text_auto(path)
    lines = text.splitlines()
    logical = []
    physical = []
    seen_logical = set()
    seen_physical = set()

    for line in lines:
        s = line.strip()
        m1 = TABLE_HEADING_RE_1.search(s)
        if m1:
            name = m1.group(1).strip()
            if name not in seen_physical:
                physical.append({'name': name, 'kind': 'physical', 'source_line': s})
                seen_physical.add(name)
        m2 = TABLE_HEADING_RE_2.search(s)
        if m2:
            name = m2.group(1).strip()
            if name not in seen_physical:
                physical.append({'name': name, 'kind': 'physical', 'source_line': s})
                seen_physical.add(name)
        for name in BACKTICK_RE.findall(s):
            if '_' in name and name not in seen_physical:
                physical.append({'name': name, 'kind': 'physical', 'source_line': s})
                seen_physical.add(name)

    for line in lines:
        s = line.strip()
        if s.startswith('- '):
            name = s[2:].strip(' -：:')
            if 2 <= len(name) <= 30 and re.search(r'[\u4e00-\u9fff]', name) and name not in seen_logical:
                logical.append({'name': name, 'kind': 'logical', 'source_line': s})
                seen_logical.add(name)
        if s.startswith('|') and s.count('|') >= 3 and '---' not in s:
            parts = [p.strip() for p in s.strip().strip('|').split('|')]
            if not parts:
                continue
            name = parts[0]
            if name and name not in {'数据类别', '字段', '类型', '说明', '当前承载表', '主要用途'} and re.search(r'[\u4e00-\u9fff]', name):
                if len(name) <= 30 and name not in seen_logical:
                    logical.append({'name': name, 'kind': 'logical', 'source_line': s})
                    seen_logical.add(name)
    return logical, physical


def choose_matches(req_text: str, interfaces: List[InterfaceRow]) -> Tuple[str, List[InterfaceRow], str]:
    for pattern, note in FRONTEND_PATTERNS:
        if pattern in req_text:
            return '无需独立接口', [], note

    req_actions = detect_actions(req_text)
    req_keywords = set()
    for iface in interfaces:
        for kw in iface.keywords:
            if kw in req_text:
                req_keywords.add(kw)

    scored = []
    for iface in interfaces:
        shared = req_keywords & iface.keywords
        score = 0
        if shared:
            score += len(shared) * 2
        if req_actions and (iface.actions & req_actions):
            score += 1
        if iface.method == 'GET' and ('查询' in req_actions or not req_actions):
            score += 1
        if iface.method in {'POST', 'PUT'} and (req_actions & {'保存', '提交上报', '审核审批', '处置流转'}):
            score += 1
        if iface.method == 'DELETE' and '删除' in req_actions:
            score += 2
        if score > 0:
            scored.append((score, iface, sorted(shared)))

    scored.sort(key=lambda x: (-x[0], x[1].name))
    top = scored[:3]
    if not top:
        return '未覆盖', [], '未找到明显对应接口'
    top_score = top[0][0]
    note = '命中关键词：' + ('、'.join(top[0][2]) if top[0][2] else '动作匹配')
    if top_score >= 4:
        return '已覆盖', [x[1] for x in top], note
    return '部分覆盖', [x[1] for x in top], note


def normalize_object_name(name: str) -> str:
    name = name.strip().lower().strip('`')
    for old in ['表', '数据', '记录', '配置', '主表', '明细', '主档']:
        name = name.replace(old, '')
    name = re.sub(r'\s+', '', name)
    return name


def source_tokens(text: str) -> List[str]:
    return [p.strip() for p in re.split(r'[、,，/\s]+', text) if p.strip()]


def map_object(obj_name: str, interfaces: List[InterfaceRow]) -> Tuple[str, List[InterfaceRow], str]:
    nobj = normalize_object_name(obj_name)
    direct, partial = [], []
    for iface in interfaces:
        tokens = source_tokens(iface.sources)
        for token in tokens:
            nt = normalize_object_name(token)
            if not nt:
                continue
            if nobj == nt or nobj in nt or nt in nobj:
                direct.append(iface)
                break
            if len(nobj) >= 2 and len(nt) >= 2 and (nobj[:2] == nt[:2] or nobj[-2:] == nt[-2:]):
                partial.append(iface)
                break
    if direct:
        return '已覆盖', direct[:3], '主要来源中存在直接对象映射'
    if partial:
        return '部分覆盖', partial[:3], '主要来源中存在近似对象映射'
    return '未覆盖', [], '接口来源中未发现直接对象映射'


def md_escape(text: str) -> str:
    return text.replace('|', '/').replace('\n', ' ')


requirement_records = []
data_records = []
summary = []

for module in MODULES:
    interfaces = parse_interface_rows(module['interface'], module['name'])
    requirements = parse_requirement_items(module['requirement'])
    logical_objects, physical_objects = parse_schema_objects(module['schema'])

    req_counter = defaultdict(int)
    for req in requirements:
        status, matches, note = choose_matches(req['text'], interfaces)
        req_counter[status] += 1
        requirement_records.append({
            'module': module['name'],
            'section': req['section'],
            'item_no': req['item_no'],
            'requirement': req['text'],
            'status': status,
            'match_interfaces': [m.name for m in matches],
            'match_urls': [m.url for m in matches],
            'note': note,
        })

    logical_counter = defaultdict(int)
    for obj in logical_objects:
        status, matches, note = map_object(obj['name'], interfaces)
        logical_counter[status] += 1
        data_records.append({
            'module': module['name'],
            'object_type': '逻辑对象',
            'object_name': obj['name'],
            'status': status,
            'match_interfaces': [m.name for m in matches],
            'match_urls': [m.url for m in matches],
            'note': note,
        })

    physical_counter = defaultdict(int)
    for obj in physical_objects:
        status, matches, note = map_object(obj['name'], interfaces)
        physical_counter[status] += 1
        data_records.append({
            'module': module['name'],
            'object_type': '物理对象',
            'object_name': obj['name'],
            'status': status,
            'match_interfaces': [m.name for m in matches],
            'match_urls': [m.url for m in matches],
            'note': note,
        })

    summary.append({
        'module': module['name'],
        'interface_count': len(interfaces),
        'requirement_count': len(requirements),
        'requirement_status': dict(req_counter),
        'logical_object_count': len(logical_objects),
        'logical_status': dict(logical_counter),
        'physical_object_count': len(physical_objects),
        'physical_status': dict(physical_counter),
    })

(OUT_DATA / 'interface_requirement_coverage.json').write_text(json.dumps(requirement_records, ensure_ascii=False, indent=2), encoding='utf-8')
(OUT_DATA / 'interface_data_coverage.json').write_text(json.dumps(data_records, ensure_ascii=False, indent=2), encoding='utf-8')
(OUT_DATA / 'interface_coverage_summary.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding='utf-8')

req_lines = ['# 接口需求覆盖矩阵', '', '## 汇总', '| 模块 | 需求数 | 已覆盖 | 部分覆盖 | 无需独立接口 | 未覆盖 |', '|---|---:|---:|---:|---:|---:|']
for item in summary:
    rs = item['requirement_status']
    req_lines.append(f"| {item['module']} | {item['requirement_count']} | {rs.get('已覆盖', 0)} | {rs.get('部分覆盖', 0)} | {rs.get('无需独立接口', 0)} | {rs.get('未覆盖', 0)} |")
req_lines.append('')
for module in MODULES:
    req_lines.append(f"## {module['name']}")
    req_lines.append('')
    req_lines.append('| 节点 | 需求项 | 状态 | 对应接口 | 说明 |')
    req_lines.append('|---|---|---|---|---|')
    for row in requirement_records:
        if row['module'] != module['name']:
            continue
        interfaces_text = '<br>'.join(row['match_interfaces']) if row['match_interfaces'] else '-'
        req_lines.append(f"| {row['section']}#{row['item_no']} | {md_escape(row['requirement'])} | {row['status']} | {md_escape(interfaces_text)} | {md_escape(row['note'])} |")
    req_lines.append('')
(OUT_DOCS / 'interface_requirement_coverage_matrix.md').write_text('\n'.join(req_lines), encoding='utf-8')

data_lines = ['# 接口数据对象覆盖矩阵', '', '## 汇总', '| 模块 | 逻辑对象数 | 逻辑已覆盖 | 逻辑部分覆盖 | 逻辑未覆盖 | 物理对象数 | 物理已覆盖 | 物理部分覆盖 | 物理未覆盖 |', '|---|---:|---:|---:|---:|---:|---:|---:|---:|']
for item in summary:
    ls = item['logical_status']
    ps = item['physical_status']
    data_lines.append(f"| {item['module']} | {item['logical_object_count']} | {ls.get('已覆盖',0)} | {ls.get('部分覆盖',0)} | {ls.get('未覆盖',0)} | {item['physical_object_count']} | {ps.get('已覆盖',0)} | {ps.get('部分覆盖',0)} | {ps.get('未覆盖',0)} |")
data_lines.append('')
for module in MODULES:
    for obj_type in ['逻辑对象', '物理对象']:
        data_lines.append(f"## {module['name']} - {obj_type}")
        data_lines.append('')
        data_lines.append('| 对象名 | 状态 | 对应接口 | 说明 |')
        data_lines.append('|---|---|---|---|')
        for row in data_records:
            if row['module'] != module['name'] or row['object_type'] != obj_type:
                continue
            interfaces_text = '<br>'.join(row['match_interfaces']) if row['match_interfaces'] else '-'
            data_lines.append(f"| {md_escape(row['object_name'])} | {row['status']} | {md_escape(interfaces_text)} | {md_escape(row['note'])} |")
        data_lines.append('')
(OUT_DOCS / 'interface_data_coverage_matrix.md').write_text('\n'.join(data_lines), encoding='utf-8')

summary_lines = ['# 接口覆盖核对结论', '', '## 总结', '本结论基于 6 个模块需求梳理、数据结构文档与当前接口清单的自动提取和保守映射生成。', '“已覆盖”表示存在明确对应接口；“部分覆盖”表示存在弱匹配或需字段级确认；“无需独立接口”表示当前更适合作为前端本地能力；“未覆盖”表示当前清单中未找到明确接口。', '', '| 模块 | 当前接口数 | 需求覆盖判断 | 数据对象覆盖判断 |', '|---|---:|---|---|']
for item in summary:
    rs = item['requirement_status']
    ps = item['physical_status']
    req_judgement = '未完全覆盖' if rs.get('未覆盖', 0) or rs.get('部分覆盖', 0) else '基本覆盖'
    data_judgement = '未完全覆盖' if ps.get('未覆盖', 0) or ps.get('部分覆盖', 0) else '基本覆盖'
    summary_lines.append(f"| {item['module']} | {item['interface_count']} | {req_judgement} | {data_judgement} |")
summary_lines.extend(['', '## 输出文件', f"- {(OUT_DOCS / 'interface_requirement_coverage_matrix.md').as_posix()}", f"- {(OUT_DOCS / 'interface_data_coverage_matrix.md').as_posix()}", f"- {(OUT_DOCS / 'interface_coverage_summary.md').as_posix()}", f"- {(OUT_DATA / 'interface_requirement_coverage.json').as_posix()}", f"- {(OUT_DATA / 'interface_data_coverage.json').as_posix()}", f"- {(OUT_DATA / 'interface_coverage_summary.json').as_posix()}" ])
(OUT_DOCS / 'interface_coverage_summary.md').write_text('\n'.join(summary_lines), encoding='utf-8')

print(OUT_DOCS / 'interface_requirement_coverage_matrix.md')
print(OUT_DOCS / 'interface_data_coverage_matrix.md')
print(OUT_DOCS / 'interface_coverage_summary.md')
print(OUT_DATA / 'interface_requirement_coverage.json')
print(OUT_DATA / 'interface_data_coverage.json')
print(OUT_DATA / 'interface_coverage_summary.json')
