from __future__ import annotations

import json
import re
from collections import defaultdict
from html import escape
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "data" / "requirements" / "nongjing_map_requirements.json"
OUT_DIR = ROOT / "docs" / "day1" / "prototype"

MODULE_FILE = {
    "财务一张图": "finance_f1_f6_wireframe_zh.html",
    "资产一张图": "asset_one_map_zh.html",
    "资源一张图": "resource_one_map_zh.html",
    "合同一张图": "contract_one_map_zh.html",
    "成员一张图": "member_one_map_zh.html",
    "股权一张图": "equity_one_map_zh.html",
    "预警监督": "warning_supervision_zh.html",
}

MODULE_ORDER = [
    "财务一张图",
    "资产一张图",
    "资源一张图",
    "合同一张图",
    "成员一张图",
    "股权一张图",
    "预警监督",
]

MODULE_UI = {
    "资产一张图": {
        "kpis": [
            ("资产总额", "12.8 亿元", "+3.2%"),
            ("经营性资产占比", "61%", "+1.4%"),
            ("闲置资产占比", "9%", "-0.8%"),
            ("资产确权完成率", "94%", "+0.6%"),
        ],
        "chart_a": "资产结构分布",
        "chart_b": "资产变动趋势",
        "table_title": "资产台账",
        "table_columns": ["资产编号", "资产类型", "权属状态", "估值", "位置", "更新时间"],
        "default_features": ["资产总览", "资产分类", "资产盘点", "资产流转", "资产处置", "确权管理"],
    },
    "资源一张图": {
        "kpis": [
            ("资源总量", "3,280 项", "+2.1%"),
            ("可利用资源", "2,640 项", "+1.8%"),
            ("资源利用率", "80.5%", "+0.9%"),
            ("重点资源覆盖率", "92%", "+0.5%"),
        ],
        "chart_a": "资源类型分布",
        "chart_b": "资源利用趋势",
        "table_title": "资源台账",
        "table_columns": ["资源编号", "资源类型", "面积(亩)", "利用状态", "所属主体", "更新时间"],
        "default_features": ["资源总览", "资源分类", "资源利用", "资源监管", "资源关联", "资源预警"],
    },
    "合同一张图": {
        "kpis": [
            ("合同总数", "1,946 份", "+4.7%"),
            ("在履合同", "1,522 份", "+2.3%"),
            ("合同金额", "8.6 亿元", "+5.1%"),
            ("履约完成率", "91%", "+1.0%"),
        ],
        "chart_a": "合同类型分布",
        "chart_b": "履约状态趋势",
        "table_title": "合同台账",
        "table_columns": ["合同编号", "合同类型", "签署方", "金额", "起止日期", "履约状态"],
        "default_features": ["合同总览", "合同检索", "履约跟踪", "到期提醒", "风险识别", "归档管理"],
    },
    "成员一张图": {
        "kpis": [
            ("成员总数", "58,420 人", "+1.9%"),
            ("活跃成员", "44,730 人", "+2.6%"),
            ("覆盖组织", "2,316 个", "+1.1%"),
            ("成员资料完整率", "96%", "+0.4%"),
        ],
        "chart_a": "成员结构分布",
        "chart_b": "成员变动趋势",
        "table_title": "成员台账",
        "table_columns": ["成员编号", "姓名", "角色", "所属组织", "联系方式", "状态"],
        "default_features": ["成员档案", "成员分类", "成员关系", "成员变更", "成员画像", "成员统计"],
    },
    "股权一张图": {
        "kpis": [
            ("股权总份额", "100%", "稳定"),
            ("股东总数", "6,842 人", "+1.2%"),
            ("本月变更", "138 笔", "+3.4%"),
            ("异常占比", "1.7%", "-0.3%"),
        ],
        "chart_a": "股权结构分布",
        "chart_b": "股权变动趋势",
        "table_title": "股权台账",
        "table_columns": ["股权编号", "成员名称", "持股比例", "出资额", "变更日期", "状态"],
        "default_features": ["股权总览", "股权登记", "股权变更", "分红口径", "确权校验", "异常识别"],
    },
    "预警监督": {
        "kpis": [
            ("预警总量", "426 条", "+6.2%"),
            ("高风险", "37 条", "-1.1%"),
            ("处理中", "148 条", "+2.8%"),
            ("闭环率", "89%", "+1.5%"),
        ],
        "chart_a": "风险类型分布",
        "chart_b": "预警处理趋势",
        "table_title": "预警台账",
        "table_columns": ["预警编号", "风险类型", "风险等级", "触发时间", "责任人", "处置状态"],
        "default_features": ["风险概览", "规则配置", "预警触发", "任务派发", "处置闭环", "监督复核"],
    },
}


def to_html_text(text: str) -> str:
    return escape(text or "").replace("\n", "<br />")


def render_module_nav(current_module: str) -> str:
    links = []
    for module in MODULE_ORDER:
        css = "nav-item nav-item-active" if module == current_module else "nav-item"
        href = MODULE_FILE[module]
        links.append(f'<a class="{css}" href="{href}">{to_html_text(module)}</a>')
    return "\n".join(links)


def short_feature(text: str, limit: int = 16) -> str:
    content = re.sub(r"\s+", "", text or "")
    parts = re.split(r"[。；;，,：:！!？?]", content)
    candidate = ""
    for part in parts:
        if part:
            candidate = part
            break
    candidate = re.sub(r"^(通过该功能|通过这个功能|该功能|系统应|系统需|系统可以|用户可以|用户可|支持|能够)", "", candidate)
    candidate = candidate.strip()
    if not candidate:
        return "功能要点"
    return candidate if len(candidate) <= limit else candidate[:limit] + "..."


def collect_feature_titles(records: list[dict], fallback: list[str], max_items: int = 8) -> list[str]:
    titles = []
    seen = set()
    for rec in records:
        title = short_feature(str(rec.get("remark_raw", "")))
        if title and title not in seen:
            seen.add(title)
            titles.append(title)
        if len(titles) >= max_items:
            break
    for item in fallback:
        if len(titles) >= max_items:
            break
        if item not in seen:
            seen.add(item)
            titles.append(item)
    return titles


def build_sample_rows(columns: list[str], module_prefix: str) -> list[list[str]]:
    statuses = ["正常", "处理中", "关注"]
    rows = []
    for idx in range(1, 4):
        row = []
        for c_index, col in enumerate(columns):
            if c_index == 0:
                row.append(f"{module_prefix}-{idx:03d}")
            elif "状态" in col:
                row.append(statuses[idx - 1])
            elif "日期" in col or "时间" in col:
                row.append(f"2026-03-0{idx}")
            elif "比例" in col:
                row.append(f"{idx * 12}%")
            elif "金额" in col or "估值" in col or "出资" in col:
                row.append(f"{idx * 120} 万元")
            elif "面积" in col:
                row.append(f"{idx * 80}")
            else:
                row.append(f"示例{idx}")
        rows.append(row)
    return rows


def render_table(columns: list[str], rows: list[list[str]]) -> str:
    head = "".join(f"<th>{to_html_text(c)}</th>" for c in columns)
    body = []
    for row in rows:
        tds = "".join(f"<td>{to_html_text(cell)}</td>" for cell in row)
        body.append(f"<tr>{tds}</tr>")
    return f"<table class=\"grid-table\"><thead><tr>{head}</tr></thead><tbody>{''.join(body)}</tbody></table>"


def render_module_page(module: str, records: list[dict]) -> str:
    cfg = MODULE_UI[module]
    feature_titles = collect_feature_titles(records, cfg["default_features"], max_items=8)

    kpi_cards = []
    for label, value, trend in cfg["kpis"]:
        kpi_cards.append(
            """
            <article class="kpi-card">
              <p class="kpi-label">{label}</p>
              <p class="kpi-value">{value}</p>
              <p class="kpi-trend">环比：{trend}</p>
            </article>
            """.format(label=to_html_text(label), value=to_html_text(value), trend=to_html_text(trend))
        )

    feature_chips = "".join(f"<span class=\"chip\">{to_html_text(item)}</span>" for item in feature_titles)
    table_html = render_table(cfg["table_columns"], build_sample_rows(cfg["table_columns"], module[:2]))

    return """<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>农经一张图-{module}原型页</title>
  <style>
    :root {{
      --bg:#f3f8f3;
      --panel:#ffffff;
      --line:#d7e2d9;
      --text:#1f2d24;
      --muted:#5f7366;
      --brand:#1d7a4e;
      --brand-soft:#e8f4ed;
    }}
    * {{ box-sizing: border-box; }}
    body {{
      margin: 0;
      font-family: "Microsoft YaHei", "PingFang SC", "Noto Sans SC", sans-serif;
      color: var(--text);
      background: radial-gradient(circle at 12% 8%, #eef7ef 0%, #f8fbf8 45%, #f1f7f2 100%);
    }}
    .layout {{ display: grid; grid-template-columns: 280px 1fr; min-height: 100vh; }}
    .side {{
      border-right: 1px solid var(--line);
      background: #f8fcf9;
      padding: 16px 12px;
      position: sticky;
      top: 0;
      height: 100vh;
      overflow: auto;
    }}
    .side h1 {{ margin: 0; font-size: 21px; }}
    .side p {{ margin: 8px 0 14px; font-size: 13px; color: var(--muted); line-height: 1.6; }}
    .nav-item {{
      display: block;
      padding: 9px 11px;
      margin-bottom: 8px;
      border: 1px solid var(--line);
      border-radius: 10px;
      text-decoration: none;
      color: var(--text);
      font-size: 14px;
      background: #fff;
    }}
    .nav-item-active {{
      border-color: #9fceb4;
      background: var(--brand-soft);
      color: #16563a;
      font-weight: 700;
    }}
    .main {{ padding: 18px; }}
    .panel {{
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: 14px;
      padding: 14px;
      margin-bottom: 12px;
    }}
    .panel h2 {{ margin: 0 0 10px; font-size: 18px; }}
    .panel .hint {{ margin: 0; color: var(--muted); font-size: 12px; line-height: 1.6; }}
    .toolbar {{
      display: grid;
      grid-template-columns: repeat(5, minmax(100px, 1fr));
      gap: 10px;
    }}
    .field label {{ display: block; font-size: 12px; color: var(--muted); margin-bottom: 4px; }}
    .field select,
    .field input,
    .field button {{
      width: 100%;
      border: 1px solid var(--line);
      border-radius: 9px;
      padding: 8px;
      font-size: 13px;
      background: #fff;
    }}
    .field button {{
      background: var(--brand);
      border-color: var(--brand);
      color: #fff;
      font-weight: 700;
      cursor: pointer;
    }}
    .ctx {{ margin: 8px 0 0; font-size: 12px; color: var(--muted); }}
    .kpi-grid {{ display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 10px; }}
    .kpi-card {{ border: 1px solid var(--line); border-radius: 12px; padding: 10px; background: #fbfefd; }}
    .kpi-label {{ margin: 0; font-size: 12px; color: var(--muted); }}
    .kpi-value {{ margin: 6px 0; font-size: 22px; font-weight: 700; color: #1a5f3f; }}
    .kpi-trend {{ margin: 0; font-size: 12px; color: #3d7f5f; }}
    .work-grid {{ display: grid; grid-template-columns: 1.2fr 1fr; gap: 10px; }}
    .block {{ border: 1px dashed #b8cfbf; border-radius: 12px; padding: 10px; background: #fcfffd; }}
    .block h3 {{ margin: 0 0 8px; font-size: 15px; }}
    .chart {{
      border: 1px solid #d5e3d9;
      border-radius: 10px;
      min-height: 146px;
      padding: 8px;
      background: linear-gradient(180deg, #fbfefb 0%, #f3f9f4 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      color: #6c7f73;
      font-size: 13px;
      margin-bottom: 8px;
    }}
    .grid-table {{ width: 100%; border-collapse: collapse; font-size: 12px; }}
    .grid-table th,
    .grid-table td {{ border: 1px solid var(--line); padding: 6px; text-align: left; }}
    .grid-table th {{ background: #f3faf5; }}
    .gis-row {{ display: grid; grid-template-columns: 1fr auto; gap: 10px; align-items: stretch; }}
    .map-box {{
      border: 1px dashed #b8cfbf;
      border-radius: 12px;
      min-height: 180px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(130deg, #f9fdf9 0%, #eef6ef 100%);
      color: #607468;
      font-size: 14px;
      padding: 12px;
      text-align: center;
    }}
    .region-list {{ display: flex; flex-direction: column; gap: 8px; min-width: 150px; }}
    .region-btn {{
      border: 1px solid #bdd4c6;
      border-radius: 9px;
      background: #fff;
      color: #1f2d24;
      padding: 8px;
      cursor: pointer;
      font-size: 13px;
    }}
    .region-btn.active {{ background: var(--brand-soft); border-color: #8ebea5; color: #145336; font-weight: 700; }}
    .chip-row {{ display: flex; flex-wrap: wrap; gap: 8px; }}
    .chip {{ border: 1px solid #c5ddce; border-radius: 999px; background: #eff8f2; color: #1e6543; padding: 5px 10px; font-size: 12px; }}
    @media (max-width: 1080px) {{
      .layout {{ grid-template-columns: 1fr; }}
      .side {{ position: static; height: auto; }}
      .toolbar {{ grid-template-columns: 1fr 1fr; }}
      .kpi-grid {{ grid-template-columns: 1fr 1fr; }}
      .work-grid {{ grid-template-columns: 1fr; }}
      .gis-row {{ grid-template-columns: 1fr; }}
      .region-list {{ flex-direction: row; flex-wrap: wrap; min-width: 0; }}
    }}
  </style>
</head>
<body>
<div class="layout">
  <aside class="side">
    <h1>农经一张图</h1>
    <p>当前模块：{module}<br />页面类型：业务原型页<br />GIS 能力：横切共享（非独立主题）</p>
    <a class="nav-item" href="nongjing_one_map_modules_zh.html">返回模块总览</a>
    {module_nav}
  </aside>

  <main class="main">
    <section class="panel">
      <div class="toolbar">
        <div class="field">
          <label>行政区划</label>
          <select id="regionSelect">
            <option value="海南省">海南省</option>
            <option value="海口市">海口市</option>
            <option value="三亚市">三亚市</option>
            <option value="文昌市">文昌市</option>
          </select>
        </div>
        <div class="field">
          <label>开始日期</label>
          <input id="startDate" type="date" value="2026-01-01" />
        </div>
        <div class="field">
          <label>结束日期</label>
          <input id="endDate" type="date" value="2026-03-31" />
        </div>
        <div class="field">
          <label>统计口径</label>
          <select id="scopeSelect">
            <option value="本级">本级</option>
            <option value="区县">区县</option>
            <option value="乡镇">乡镇</option>
          </select>
        </div>
        <div class="field">
          <label>执行查询</label>
          <button type="button" id="applyBtn">应用筛选</button>
        </div>
      </div>
      <p class="ctx" id="ctx">当前筛选：海南省 | 2026-01-01 至 2026-03-31 | 本级</p>
    </section>

    <section class="panel">
      <h2>{module}业务总览</h2>
      <p class="hint">需求条目数：{count}。该页面以原始需求为依据做界面归并，展示关键指标、分析视图、台账和 GIS 联动，不直接平铺整段需求描述。</p>
      <div class="kpi-grid">
        {kpi_cards}
      </div>
    </section>

    <section class="panel">
      <h2>分析工作区</h2>
      <div class="work-grid">
        <div class="block">
          <h3>{chart_a}</h3>
          <div class="chart">图表占位：支持按区划和时间联动展示</div>
          <h3>{chart_b}</h3>
          <div class="chart">图表占位：支持趋势对比与异常识别</div>
        </div>
        <div class="block">
          <h3>{table_title}</h3>
          {table_html}
        </div>
      </div>
    </section>

    <section class="panel">
      <h2>共享 GIS 联动区（横切）</h2>
      <div class="gis-row">
        <div class="map-box">地图联动占位<br />点击右侧区域按钮后，更新当前筛选并驱动上方指标与图表。</div>
        <div class="region-list">
          <button type="button" class="region-btn active" data-region="海南省">海南省</button>
          <button type="button" class="region-btn" data-region="海口市">海口市</button>
          <button type="button" class="region-btn" data-region="三亚市">三亚市</button>
          <button type="button" class="region-btn" data-region="文昌市">文昌市</button>
        </div>
      </div>
    </section>

    <section class="panel">
      <h2>需求归并后的功能点</h2>
      <div class="chip-row">{feature_chips}</div>
    </section>
  </main>
</div>

<script>
(function () {{
  const regionSelect = document.getElementById('regionSelect');
  const startDate = document.getElementById('startDate');
  const endDate = document.getElementById('endDate');
  const scopeSelect = document.getElementById('scopeSelect');
  const applyBtn = document.getElementById('applyBtn');
  const ctx = document.getElementById('ctx');
  const regionBtns = Array.from(document.querySelectorAll('.region-btn'));

  function refreshCtx() {{
    ctx.textContent = `当前筛选：${{regionSelect.value}} | ${{startDate.value}} 至 ${{endDate.value}} | ${{scopeSelect.value}}`;
  }}

  applyBtn.addEventListener('click', refreshCtx);

  regionBtns.forEach((btn) => {{
    btn.addEventListener('click', () => {{
      regionBtns.forEach((x) => x.classList.remove('active'));
      btn.classList.add('active');
      regionSelect.value = btn.dataset.region;
      refreshCtx();
    }});
  }});
}})();
</script>
</body>
</html>
""".format(
        module=to_html_text(module),
        count=len(records),
        module_nav=render_module_nav(module),
        kpi_cards="\n".join(kpi_cards),
        chart_a=to_html_text(cfg["chart_a"]),
        chart_b=to_html_text(cfg["chart_b"]),
        table_title=to_html_text(cfg["table_title"]),
        table_html=table_html,
        feature_chips=feature_chips,
    )


def render_overview(module_counts: dict[str, int]) -> str:
    cards = []
    for module in MODULE_ORDER:
        count = module_counts.get(module, 0)
        href = MODULE_FILE[module]
        cards.append(
            """
            <section class="card" id="m-{module}">
              <h2>{module}</h2>
              <p class="meta">需求条目数：{count}</p>
              <a class="btn" href="{href}">进入详细原型</a>
            </section>
            """.format(module=to_html_text(module), count=count, href=href)
        )

    quick_links = "".join(
        f'<a href="#m-{to_html_text(m)}">{to_html_text(m)}</a>' for m in MODULE_ORDER
    )

    return """<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>农经一张图-二级模块总览</title>
  <style>
    :root {{ --bg:#f4f8f3; --card:#fff; --line:#d7e3da; --ink:#1f2e24; --muted:#637567; --brand:#1f7a4f; }}
    * {{ box-sizing:border-box; }}
    body {{ margin:0; font-family:"Microsoft YaHei","PingFang SC","Noto Sans SC",sans-serif; color:var(--ink); background:linear-gradient(145deg,#f8fbf9 0%,#edf5ee 70%,#f9fcf8 100%); }}
    .wrap {{ max-width:1200px; margin:0 auto; padding:18px; }}
    .head {{ background:var(--card); border:1px solid var(--line); border-radius:14px; padding:14px; margin-bottom:12px; }}
    h1 {{ margin:0; font-size:24px; }}
    .sub {{ margin:8px 0 0; color:var(--muted); font-size:13px; line-height:1.6; }}
    .quick {{ margin-top:10px; display:flex; flex-wrap:wrap; gap:8px; }}
    .quick a {{ text-decoration:none; color:var(--ink); border:1px solid var(--line); border-radius:999px; padding:6px 10px; font-size:12px; background:#fff; }}
    .grid {{ display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:10px; }}
    .card {{ background:var(--card); border:1px solid var(--line); border-radius:14px; padding:12px; min-height:160px; display:flex; flex-direction:column; }}
    .card h2 {{ margin:0 0 8px; font-size:18px; }}
    .meta {{ margin:0 0 12px; color:var(--muted); font-size:13px; }}
    .btn {{ margin-top:auto; display:inline-block; text-decoration:none; text-align:center; border:1px solid var(--brand); color:#fff; background:var(--brand); padding:8px 10px; border-radius:10px; font-size:13px; font-weight:700; }}
    .note {{ margin-top:12px; color:var(--muted); font-size:12px; }}
    @media (max-width:1024px) {{ .grid {{ grid-template-columns:1fr 1fr; }} }}
    @media (max-width:700px) {{ .grid {{ grid-template-columns:1fr; }} }}
  </style>
</head>
<body>
  <div class="wrap">
    <section class="head">
      <h1>农经一张图</h1>
      <p class="sub">以下为二级模块总览。每个模块均可进入对应原型页。GIS 作为横切能力贯穿所有模块，不单列为独立主题模块。</p>
      <div class="quick">{quick_links}</div>
    </section>

    <section class="grid">
      {cards}
    </section>

    <p class="note">数据源：data/requirements/nongjing-map/nongjing_map_requirements.json（用于原型功能归并）</p>
  </div>
</body>
</html>
""".format(quick_links=quick_links, cards="\n".join(cards))


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    data = json.loads(DATA_PATH.read_text(encoding="utf-8"))
    records = data.get("records", [])

    grouped: dict[str, list[dict]] = defaultdict(list)
    for rec in records:
        module = (rec.get("level2_filled") or "").strip()
        if module:
            grouped[module].append(rec)

    for module in grouped:
        grouped[module].sort(key=lambda r: int(r.get("row_no", 0)))

    module_counts = {m: len(grouped.get(m, [])) for m in MODULE_ORDER}

    for module in MODULE_ORDER:
        if module == "财务一张图":
            continue
        page = render_module_page(module, grouped.get(module, []))
        (OUT_DIR / MODULE_FILE[module]).write_text(page, encoding="utf-8")

    overview = render_overview(module_counts)
    (OUT_DIR / "nongjing_one_map_modules_zh.html").write_text(overview, encoding="utf-8")

    print("生成完成")
    for module in MODULE_ORDER:
        print(f"{module}: {module_counts[module]} -> {MODULE_FILE[module]}")


if __name__ == "__main__":
    main()

