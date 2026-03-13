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
        'schema_paths': [
            Path(r'F:/待办/2026/三农金融/4.原型图/1.农经一张图/农经一张图数据结构文档.md'),
            Path(r'F:/待办/2026/三农金融/4.原型图/1.农经一张图/需求梳理与数据结构映射.md'),
        ],
        'interface': BASE / 'docs' / 'interface_detail_nongjing.md',
    },
    {
        'key': 'village_finance',
        'name': '村委财务事务管理系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/2.村委财务事务管理系统/村委财务事务管理系统-需求梳理.md'),
        'schema_paths': [
            Path(r'F:/待办/2026/三农金融/4.原型图/2.村委财务事务管理系统/村委财务事务管理系统.md'),
            Path(r'F:/待办/2026/三农金融/4.原型图/2.村委财务事务管理系统/补充表-建议.md'),
            Path(r'F:/待办/2026/三农金融/4.原型图/2.村委财务事务管理系统/需求梳理与数据结构映射说明.md'),
        ],
        'interface': BASE / 'docs' / 'interface_detail_village_finance.md',
    },
    {
        'key': 'income_ledger',
        'name': '村集体经济收入台账',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/3.村集体经济收入台账/村集体经济收入台账-需求梳理.md'),
        'schema_paths': [
            Path(r'F:/待办/2026/三农金融/4.原型图/3.村集体经济收入台账/村集体经济收入台账数据结构文档.md'),
        ],
        'interface': BASE / 'docs' / 'interface_detail_income_ledger.md',
    },
    {
        'key': 'performance',
        'name': '村集体绩效评价管理系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/4.村集体绩效评价管理系统/村集体绩效评价管理系统-需求梳理.md'),
        'schema_paths': [
            Path(r'F:/待办/2026/三农金融/4.原型图/4.村集体绩效评价管理系统/村集体绩效评价管理系统数据结构文档.md'),
        ],
        'interface': BASE / 'docs' / 'interface_detail_performance.md',
    },
    {
        'key': 'audit',
        'name': '村集体智能审计系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/5.村集体智能审计系统/村集体智能审计系统-需求梳理.md'),
        'schema_paths': [
            Path(r'F:/待办/2026/三农金融/4.原型图/5.村集体智能审计系统/村集体智能审计系统数据结构文档.md'),
        ],
        'interface': BASE / 'docs' / 'interface_detail_audit.md',
    },
    {
        'key': 'entity_supervision',
        'name': '新型农业经营主体财务经营监管系统',
        'requirement': Path(r'F:/待办/2026/三农金融/4.原型图/6.新型农业经营主体财务经营监管系统/新型农业经营主体财务经营监管系统-三端-需求梳理.md'),
        'schema_paths': [
            Path(r'F:/待办/2026/三农金融/4.原型图/6.新型农业经营主体财务经营监管系统/新型农业经营主体财务经营监管系统数据结构文档.md'),
        ],
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
    '当前', '对应', '快速', '方便', '相关信息', '具体信息', '详细信息', '详细数据', '综合管理', '一张图', '图统计',
    '数据库', '结构', '设计', '文档', '总体映射原则', '覆盖评价', '需求内容', '对应数据表'
}

FRONTEND_PATTERNS = [
    ('显示当前的日期和具体时间', '前端本地时间展示'),
    ('准确显示当前的日期和具体时间', '前端本地时间展示'),
]

OBJECT_ALIASES = {
    '农经一张图': {
        '天气数据': ['fact_weather_daily'],
        '财务月度汇总': ['fact_village_finance_monthly'],
        '财务总览派生数据': ['mv_finance_overview_monthly'],
        '财务收入分档派生数据': ['mv_finance_income_band_monthly', 'mv_finance_income_band_summary'],
        '资产负债快照': ['fact_balance_sheet_snapshot'],
        '收益分配快照': ['fact_income_distribution_snapshot'],
        '资产专题汇总': ['fact_asset_summary_monthly'],
        '资源专题汇总': ['fact_resource_summary_monthly'],
        '合同专题汇总': ['fact_contract_summary_monthly'],
        '成员专题汇总': ['fact_member_summary_monthly'],
        '股权专题汇总': ['fact_equity_summary_monthly'],
        '预警事件数据': ['fact_warning_event'],
        '收入分档配置': ['dim_income_band'],
    },
    '村委财务事务管理系统': {
        '组织机构': ['sys_org'],
        '用户信息': ['sys_user'],
        '角色信息': ['sys_role'],
        '权限信息': ['sys_permission', 'sys_role_permission', 'sys_role_menu'],
        '岗位信息': ['wf_approval_post', 'wf_post_user'],
        '账套信息': ['fin_ledger', '账套表'],
        '会计期间': ['fin_period', '会计期间表'],
        '会计科目': ['fin_subject', '会计科目表'],
        '科目类别': ['fin_subject_category', '科目类别表'],
        '凭证模板': ['fin_voucher_template', '凭证模板表'],
        '结转模板': ['fin_carry_forward_template', '结转模板表'],
        '银行账户': ['fin_bank_account', '银行账户表'],
        '现金账户': ['fin_cash_account', '现金账户表'],
        '资产分类': ['asset_category', '资产分类表'],
        '资产卡片': ['asset_card', '资产卡片表'],
        '合同信息': ['contract_main', '合同主表'],
        '审批流程定义': ['wf_definition', '流程定义表'],
        '记账凭证': ['fin_voucher', '凭证主表'],
        '凭证明细': ['fin_voucher_entry', '凭证明细表'],
        '银行日记账': ['bank_journal', '银行日记账表'],
        '现金日记账': ['cash_journal', '现金日记账表'],
        '内部转账': ['fin_internal_transfer', '内部转账表'],
        '出纳对账': ['fin_reconciliation', '出纳对账表'],
        '期末结账': ['fin_period_close_task', '期末结账主表'],
        '资产折旧': ['asset_depreciation', '资产折旧表'],
        '资产变更': ['asset_change', '资产变更表'],
        '资产处置': ['asset_disposal', '资产处置表'],
        '资产盘点': ['asset_inventory', '资产盘点表'],
        '合同变更': ['contract_change', '合同变更表'],
        '合同验收': ['contract_acceptance', '合同验收表'],
        '合同终止': ['contract_termination', '合同终止表'],
        '合同续签': ['contract_renewal', '合同续签表'],
        '合同收付款': ['contract_payment', '合同收付款表'],
        '审批实例': ['wf_instance', '审批实例表'],
        '审批任务': ['wf_task', '审批任务表'],
        '审批历史': ['wf_task_history', '审批历史表'],
        '银行交易流水': ['ync_bank_transaction', '银行交易流水表'],
        '银行余额': ['ync_bank_balance', '银行余额表'],
        '回单下载记录': ['ync_receipt_file', '电子回单文件表', '回单下载记录表'],
        '操作日志': ['sys_log_operation', '操作日志表'],
        '接口调用日志': ['sys_log_interface', '接口调用日志表'],
        '收入模板表': ['收入模板表', 'fin_income_template'],
        '支出模板表': ['支出模板表', 'fin_expense_template'],
        '出纳初始化模板表': ['出纳初始化模板表', 'fin_cashier_init_template'],
        '凭证回收站表': ['凭证回收站表', 'fin_voucher_recycle'],
        '凭证打印配置表': ['凭证打印配置表', 'fin_voucher_print_config'],
        '报表打印配置表': ['报表打印配置表', 'rep_report_print_config'],
    },
    '村集体经济收入台账': {
        '特殊区域标识': ['region_special_tag'],
        '特殊区域标签表': ['region_special_tag'],
        '特殊区域档案表': ['region_special_archive'],
        '5万/10万清单配置': ['key_list_config'],
        '5万/10万清单维护表': ['key_list_config'],
        '填报时间配置': ['report_window_config'],
        '台账附件数据': ['ledger_attachment'],
        '台账附件表': ['ledger_attachment'],
        '上报流转记录': ['submission_flow_log'],
        '信息收集统计快照': ['info_collection_stat_snapshot'],
        'GDP增速目标记录': ['gdp_target_record'],
        '接口同步日志': ['interface_sync_log'],
    },
    '村集体绩效评价管理系统': {
        '用户表': ['sys_user'],
        '角色表': ['sys_role'],
        '用户角色表': ['sys_user_role'],
        '权限表': ['sys_permission'],
        '角色权限表': ['sys_role_permission'],
        '密码策略': ['sys_password_policy'],
    },
    '村集体智能审计系统': {
        '用户表': ['sys_user'],
        '角色表': ['sys_role'],
        '用户角色关联表': ['sys_user_role'],
        '角色菜单权限表': ['sys_role_menu'],
        '审计事项库': ['base_audit_item_lib'],
        '流程模板表': ['base_process_template'],
        '方案审计事项表': ['audit_scheme_item'],
        '附件表': ['sys_attachment'],
    },
    '新型农业经营主体财务经营监管系统': {
        '店铺表': ['biz_shop', '店铺主表'],
        '客户档案表': ['biz_customer', '客户主表'],
        '仓库表': ['inv_warehouse', '仓库主表'],
        '计量单位配置表': ['inv_unit_config', '计量单位表'],
        '采购退货单表': ['inv_purchase_return'],
        '销售退货单表': ['inv_sale_return'],
        '库存调拨单表': ['inv_transfer_order'],
        '金融产品表': ['fin_product', '金融产品主表'],
        '金融产品发布日志表': ['fin_product_publish_log'],
        '还款记录表': ['fin_loan_repay', '贷款还款记录表'],
        '贷款还款计划表': ['fin_loan_repay_plan'],
        '逾期催收记录表': ['fin_collection_record'],
        '通知公告表': ['gov_notice', '通知公告主表'],
        '通知公告阅读记录表': ['gov_notice_read_log'],
    },
}

CHINESE_SEQ_RE = re.compile(r'[\u4e00-\u9fffA-Za-z0-9_]+')
REQ_ITEM_RE = re.compile(r'^(\d+)\.\s*(.+)$')
TABLE_HEADING_RE_1 = re.compile(r'^##\s*\d+\.\s*([A-Za-z0-9_]+)\b')
TABLE_HEADING_RE_2 = re.compile(r'^(?:\*\*表：|###\s*表：)\s*`?([A-Za-z0-9_]+)`?')
BACKTICK_RE = re.compile(r'`([A-Za-z0-9_]+)`')

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


def read_text_auto(path: Path) -> str:
    for enc in ('utf-8-sig', 'utf-16', 'gb18030', 'utf-8'):
        try:
            return path.read_text(encoding=enc)
        except UnicodeDecodeError:
            continue
    return path.read_text(encoding='utf-8', errors='ignore')


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
    return token.strip('_- /')


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


def normalize_object_name(name: str) -> str:
    name = name.strip().lower().strip('`')
    for old in ['表', '数据', '记录', '配置', '主表', '明细', '主档']:
        name = name.replace(old, '')
    return re.sub(r'\s+', '', name)


def source_tokens(text: str) -> List[str]:
    return [p.strip() for p in re.split(r'[、,，/\s]+', text) if p.strip()]


def parse_interface_rows(path: Path, module_name: str) -> List[InterfaceRow]:
    rows = []
    for line in read_text_auto(path).splitlines():
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
            actions=detect_actions(name + purpose),
        ))
    return rows


def parse_requirement_items(path: Path) -> List[dict]:
    items = []
    section = '未分组'
    for line in read_text_auto(path).splitlines():
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


def parse_schema_objects(paths: List[Path]) -> Tuple[List[dict], List[dict]]:
    logical, physical = [], []
    seen_logical, seen_physical = set(), set()
    for path in paths:
        text = read_text_auto(path)
        lines = text.splitlines()
        for line in lines:
            s = line.strip()
            m1 = TABLE_HEADING_RE_1.search(s)
            if m1:
                name = m1.group(1).strip()
                if name not in seen_physical:
                    physical.append({'name': name, 'kind': 'physical', 'source': str(path)})
                    seen_physical.add(name)
            m2 = TABLE_HEADING_RE_2.search(s)
            if m2:
                name = m2.group(1).strip()
                if name not in seen_physical:
                    physical.append({'name': name, 'kind': 'physical', 'source': str(path)})
                    seen_physical.add(name)
            for name in BACKTICK_RE.findall(s):
                if '_' in name and name not in seen_physical:
                    physical.append({'name': name, 'kind': 'physical', 'source': str(path)})
                    seen_physical.add(name)
        for line in lines:
            s = line.strip()
            if s.startswith('- '):
                name = s[2:].strip(' -：:')
                if 2 <= len(name) <= 40 and re.search(r'[\u4e00-\u9fff]', name) and name not in seen_logical:
                    logical.append({'name': name, 'kind': 'logical', 'source': str(path)})
                    seen_logical.add(name)
            if s.startswith('|') and s.count('|') >= 3 and '---' not in s:
                parts = [p.strip() for p in s.strip().strip('|').split('|')]
                if parts:
                    name = parts[0]
                    if name and name not in {'数据类别', '字段', '类型', '说明', '当前承载表', '主要用途'} and re.search(r'[\u4e00-\u9fff]', name):
                        if len(name) <= 40 and name not in seen_logical:
                            logical.append({'name': name, 'kind': 'logical', 'source': str(path)})
                            seen_logical.add(name)
    return logical, physical


def choose_matches(req_text: str, interfaces: List[InterfaceRow]) -> Tuple[str, List[InterfaceRow], str]:
    for pattern, note in FRONTEND_PATTERNS:
        if pattern in req_text:
            return '无需独立接口', [], note
    req_actions = detect_actions(req_text)
    req_keywords = set()
    for iface in interfaces:
        req_keywords |= {kw for kw in iface.keywords if kw in req_text}
    scored = []
    for iface in interfaces:
        shared = req_keywords & iface.keywords
        score = 0
        if shared:
            score += len(shared) * 2
        if req_actions & iface.actions:
            score += 1
        if iface.method == 'GET' and ('查询' in req_actions or not req_actions):
            score += 1
        if iface.method in {'POST', 'PUT'} and req_actions & {'保存', '提交上报', '审核审批', '处置流转'}:
            score += 1
        if iface.method == 'DELETE' and '删除' in req_actions:
            score += 2
        if score > 0:
            scored.append((score, iface, sorted(shared)))
    scored.sort(key=lambda x: (-x[0], x[1].name))
    if not scored:
        return '未覆盖', [], '未找到明显对应接口'
    top = scored[:3]
    note = '命中关键词：' + ('、'.join(top[0][2]) if top[0][2] else '动作匹配')
    return ('已覆盖' if top[0][0] >= 4 else '部分覆盖'), [x[1] for x in top], note


def map_object(module_name: str, obj_name: str, interfaces: List[InterfaceRow]) -> Tuple[str, List[InterfaceRow], str]:
    aliases = [obj_name] + OBJECT_ALIASES.get(module_name, {}).get(obj_name, [])
    normalized_aliases = [normalize_object_name(x) for x in aliases if normalize_object_name(x)]
    direct, partial = [], []
    for iface in interfaces:
        tokens = [normalize_object_name(x) for x in source_tokens(iface.sources)]
        tokens = [t for t in tokens if t]
        if any(a == t or a in t or t in a for a in normalized_aliases for t in tokens):
            direct.append(iface)
            continue
        if any(len(a) >= 2 and len(t) >= 2 and (a[:2] == t[:2] or a[-2:] == t[-2:]) for a in normalized_aliases for t in tokens):
            partial.append(iface)
    if direct:
        return '已覆盖', direct[:3], '主要来源中存在直接对象或别名映射'
    if partial:
        return '部分覆盖', partial[:3], '主要来源中存在近似对象或别名映射'
    return '未覆盖', [], '接口来源中未发现直接对象映射'


def md_escape(text: str) -> str:
    return str(text).replace('|', '/').replace('\n', ' ')


requirement_records = []
data_records = []
summary = []

for module in MODULES:
    interfaces = parse_interface_rows(module['interface'], module['name'])
    requirements = parse_requirement_items(module['requirement'])
    logical_objects, physical_objects = parse_schema_objects(module['schema_paths'])

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
        status, matches, note = map_object(module['name'], obj['name'], interfaces)
        logical_counter[status] += 1
        data_records.append({
            'module': module['name'],
            'object_type': '逻辑对象',
            'object_name': obj['name'],
            'status': status,
            'match_interfaces': [m.name for m in matches],
            'match_urls': [m.url for m in matches],
            'note': note,
            'source_file': obj['source'],
        })

    physical_counter = defaultdict(int)
    for obj in physical_objects:
        status, matches, note = map_object(module['name'], obj['name'], interfaces)
        physical_counter[status] += 1
        data_records.append({
            'module': module['name'],
            'object_type': '物理对象',
            'object_name': obj['name'],
            'status': status,
            'match_interfaces': [m.name for m in matches],
            'match_urls': [m.url for m in matches],
            'note': note,
            'source_file': obj['source'],
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

req_json = OUT_DATA / 'interface_requirement_coverage_v2.json'
data_json = OUT_DATA / 'interface_data_coverage_v2.json'
summary_json = OUT_DATA / 'interface_coverage_summary_v2.json'
req_json.write_text(json.dumps(requirement_records, ensure_ascii=False, indent=2), encoding='utf-8')
data_json.write_text(json.dumps(data_records, ensure_ascii=False, indent=2), encoding='utf-8')
summary_json.write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding='utf-8')

req_md = OUT_DOCS / 'interface_requirement_coverage_matrix_v2.md'
data_md = OUT_DOCS / 'interface_data_coverage_matrix_v2.md'
summary_md = OUT_DOCS / 'interface_coverage_summary_v2.md'

req_lines = ['# 接口需求覆盖矩阵（第二版）', '', '## 汇总', '| 模块 | 需求数 | 已覆盖 | 部分覆盖 | 无需独立接口 | 未覆盖 |', '|---|---:|---:|---:|---:|---:|']
for item in summary:
    rs = item['requirement_status']
    req_lines.append(f"| {item['module']} | {item['requirement_count']} | {rs.get('已覆盖',0)} | {rs.get('部分覆盖',0)} | {rs.get('无需独立接口',0)} | {rs.get('未覆盖',0)} |")
req_md.write_text('\n'.join(req_lines), encoding='utf-8')

data_lines = ['# 接口数据对象覆盖矩阵（第二版）', '', '## 汇总', '| 模块 | 逻辑对象数 | 逻辑已覆盖 | 逻辑部分覆盖 | 逻辑未覆盖 | 物理对象数 | 物理已覆盖 | 物理部分覆盖 | 物理未覆盖 |', '|---|---:|---:|---:|---:|---:|---:|---:|---:|']
for item in summary:
    ls = item['logical_status']
    ps = item['physical_status']
    data_lines.append(f"| {item['module']} | {item['logical_object_count']} | {ls.get('已覆盖',0)} | {ls.get('部分覆盖',0)} | {ls.get('未覆盖',0)} | {item['physical_object_count']} | {ps.get('已覆盖',0)} | {ps.get('部分覆盖',0)} | {ps.get('未覆盖',0)} |")
data_md.write_text('\n'.join(data_lines), encoding='utf-8')

sum_lines = ['# 接口覆盖核对结论（第二版）', '', '## 总结', '本版在第一版自动提取基础上，引入对象别名映射，并纳入补充表建议与需求-数据结构映射说明。', '因此本版更适合判断“命名口径问题”与“真实未覆盖项”之间的差异。', '', '| 模块 | 当前接口数 | 需求覆盖判断 | 数据对象覆盖判断 |', '|---|---:|---|---|']
for item in summary:
    rs = item['requirement_status']
    ps = item['physical_status']
    req_judgement = '未完全覆盖' if rs.get('未覆盖',0) or rs.get('部分覆盖',0) else '基本覆盖'
    data_judgement = '未完全覆盖' if ps.get('未覆盖',0) or ps.get('部分覆盖',0) else '基本覆盖'
    sum_lines.append(f"| {item['module']} | {item['interface_count']} | {req_judgement} | {data_judgement} |")
sum_lines += ['', '## 输出文件', f'- {req_md.as_posix()}', f'- {data_md.as_posix()}', f'- {summary_md.as_posix()}', f'- {req_json.as_posix()}', f'- {data_json.as_posix()}', f'- {summary_json.as_posix()}']
summary_md.write_text('\n'.join(sum_lines), encoding='utf-8')

print(req_md)
print(data_md)
print(summary_md)
print(req_json)
print(data_json)
print(summary_json)
