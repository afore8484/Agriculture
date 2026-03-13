#!/usr/bin/env python3
from __future__ import annotations

import argparse
import html
import json
import re
import zipfile
from collections import OrderedDict
from datetime import datetime
from pathlib import Path
from xml.etree import ElementTree as ET

NS_MAIN = {"main": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
NS_REL = {"pkgrel": "http://schemas.openxmlformats.org/package/2006/relationships"}

SHEET_NAME = "\u9875\u9762\u529f\u80fd\u5b57\u5178"

HEADER_ID = "\u539f\u578b\u7f16\u53f7"
HEADER_PAGE = "\u9875\u9762\u540d\u79f0"
HEADER_MODULE = "\u6240\u5c5e\u6a21\u5757"
HEADER_OBJECT = "\u9875\u9762\u627f\u8f7d\u5bf9\u8c61"
HEADER_FUNCS = "\u9875\u9762\u529f\u80fd\u6e05\u5355"
HEADER_LAYOUT = "\u63a8\u8350\u9875\u9762\u7ed3\u6784"
HEADER_NOTE = "\u5907\u6ce8"

SYSTEM_NAME = "\u6751\u59d4\u8d22\u52a1\u4e8b\u52a1\u7ba1\u7406\u7cfb\u7edf"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate prototype docs from page dictionary xlsx/json.")
    parser.add_argument(
        "--xlsx",
        default="docs/\u9875\u9762\u529f\u80fd\u5b57\u5178_\u6751\u59d4\u8d22\u52a1\u4e8b\u52a1\u7ba1\u7406\u7cfb\u7edf.xlsx",
        help="Path to source xlsx file",
    )
    parser.add_argument(
        "--out-dir",
        default="docs/\u6751\u59d4\u8d22\u52a1\u4e8b\u52a1\u7ba1\u7406\u7cfb\u7edf/prototype",
        help="Dedicated output directory",
    )
    parser.add_argument(
        "--mode",
        choices=["full", "template-page"],
        default="full",
        help="full: regenerate module prototype docs; template-page: render one page in strict template format",
    )
    parser.add_argument("--page-id", default="P02", help="Target page id for template-page mode")
    parser.add_argument(
        "--json-source",
        default="",
        help="Optional structured json source path. If empty, will use out-dir json or xlsx parsed records.",
    )
    return parser.parse_args()


def col_to_index(col: str) -> int:
    value = 0
    for ch in col:
        if "A" <= ch <= "Z":
            value = value * 26 + (ord(ch) - 64)
    return value - 1


def split_ref(ref: str) -> tuple[int, int]:
    match = re.match(r"([A-Z]+)(\d+)", ref)
    if not match:
        return 0, 0
    return int(match.group(2)), col_to_index(match.group(1))


def parse_xlsx_sheet_rows(xlsx_path: Path, target_sheet_name: str) -> list[list[str]]:
    with zipfile.ZipFile(xlsx_path) as zf:
        workbook_xml = ET.fromstring(zf.read("xl/workbook.xml"))
        rels_xml = ET.fromstring(zf.read("xl/_rels/workbook.xml.rels"))

        rel_map: dict[str, str] = {}
        for rel in rels_xml.findall("pkgrel:Relationship", NS_REL):
            rid = rel.attrib.get("Id", "")
            target = rel.attrib.get("Target", "").lstrip("/")
            if target and not target.startswith("xl/"):
                target = "xl/" + target
            rel_map[rid] = target

        sheet_path = None
        sheets = workbook_xml.find("main:sheets", NS_MAIN)
        if sheets is None:
            raise ValueError("No sheets found in workbook.xml")

        for sheet in sheets.findall("main:sheet", NS_MAIN):
            name = sheet.attrib.get("name", "")
            rid = sheet.attrib.get("{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id", "")
            if name == target_sheet_name:
                sheet_path = rel_map.get(rid)
                break

        if not sheet_path:
            first_sheet = sheets.findall("main:sheet", NS_MAIN)[0]
            rid = first_sheet.attrib.get("{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id", "")
            sheet_path = rel_map.get(rid)

        shared_strings: list[str] = []
        if "xl/sharedStrings.xml" in zf.namelist():
            sst_xml = ET.fromstring(zf.read("xl/sharedStrings.xml"))
            for si in sst_xml.findall("main:si", NS_MAIN):
                text = "".join((t.text or "") for t in si.findall(".//main:t", NS_MAIN))
                shared_strings.append(text)

        sheet_xml = ET.fromstring(zf.read(sheet_path))
        sheet_data = sheet_xml.find("main:sheetData", NS_MAIN)
        if sheet_data is None:
            return []

        rows: list[list[str]] = []
        for row in sheet_data.findall("main:row", NS_MAIN):
            row_map: dict[int, str] = {}
            for cell in row.findall("main:c", NS_MAIN):
                ref = cell.attrib.get("r", "")
                _, col_idx = split_ref(ref)

                ctype = cell.attrib.get("t", "")
                value = ""
                if ctype == "s":
                    v = cell.find("main:v", NS_MAIN)
                    if v is not None and v.text is not None:
                        idx = int(v.text)
                        value = shared_strings[idx] if idx < len(shared_strings) else ""
                elif ctype == "inlineStr":
                    inline = cell.find("main:is", NS_MAIN)
                    if inline is not None:
                        value = "".join((t.text or "") for t in inline.findall(".//main:t", NS_MAIN))
                else:
                    v = cell.find("main:v", NS_MAIN)
                    if v is not None and v.text is not None:
                        value = v.text

                row_map[col_idx] = value.strip()

            if row_map:
                max_idx = max(row_map.keys())
                rows.append([row_map.get(i, "") for i in range(max_idx + 1)])

        return rows


def to_records(rows: list[list[str]]) -> list[dict[str, str]]:
    if not rows:
        return []

    header = rows[0]
    idx_map = {
        HEADER_ID: header.index(HEADER_ID) if HEADER_ID in header else 0,
        HEADER_PAGE: header.index(HEADER_PAGE) if HEADER_PAGE in header else 1,
        HEADER_MODULE: header.index(HEADER_MODULE) if HEADER_MODULE in header else 2,
        HEADER_OBJECT: header.index(HEADER_OBJECT) if HEADER_OBJECT in header else 3,
        HEADER_FUNCS: header.index(HEADER_FUNCS) if HEADER_FUNCS in header else 4,
        HEADER_LAYOUT: header.index(HEADER_LAYOUT) if HEADER_LAYOUT in header else 5,
        HEADER_NOTE: header.index(HEADER_NOTE) if HEADER_NOTE in header else 6,
    }

    records: list[dict[str, str]] = []

    for row in rows[1:]:
        def pick(col_name: str) -> str:
            idx = idx_map[col_name]
            return row[idx].strip() if idx < len(row) else ""

        page_id = pick(HEADER_ID)
        page_name = pick(HEADER_PAGE)
        module = pick(HEADER_MODULE)

        if not (page_id or page_name or module):
            continue

        records.append(
            {
                "prototype_id": page_id,
                "page_name": page_name,
                "module": module,
                "carrier": pick(HEADER_OBJECT),
                "functions": pick(HEADER_FUNCS),
                "layout": pick(HEADER_LAYOUT),
                "note": pick(HEADER_NOTE),
            }
        )

    def sort_key(item: dict[str, str]) -> tuple[int, str]:
        m = re.search(r"(\d+)", item["prototype_id"])
        if m:
            return int(m.group(1)), item["prototype_id"]
        return 9999, item["prototype_id"]

    records.sort(key=sort_key)
    return records


def group_by_module(records: list[dict[str, str]]) -> OrderedDict[str, list[dict[str, str]]]:
    grouped: OrderedDict[str, list[dict[str, str]]] = OrderedDict()
    for rec in records:
        module = rec.get("module", "") or "\u672a\u5206\u7c7b\u6a21\u5757"
        grouped.setdefault(module, []).append(rec)
    return grouped


def build_mermaid(grouped: OrderedDict[str, list[dict[str, str]]]) -> str:
    lines = ["flowchart TD", f'  ROOT["{SYSTEM_NAME}"]']
    for mi, (module, pages) in enumerate(grouped.items(), start=1):
        mid = f"M{mi}"
        lines.append(f'  ROOT --> {mid}["{module}"]')
        for pi, page in enumerate(pages, start=1):
            pid = f"{mid}P{pi}"
            label = f"{page['prototype_id']} {page['page_name']}"
            lines.append(f'  {mid} --> {pid}["{label}"]')
    return "\n".join(lines)


def sanitize_filename_part(value: str) -> str:
    value = re.sub(r'[\/:*?"<>|]+', "-", value)
    value = re.sub(r"\s+", " ", value).strip()
    return value or "untitled"


def build_page_stem(page: dict[str, str]) -> str:
    return f"{page.get('prototype_id', 'PX')}_{sanitize_filename_part(page.get('page_name', '?????'))}"


def build_page_link_map(records: list[dict[str, str]]) -> dict[str, dict[str, str]]:
    page_links: dict[str, dict[str, str]] = {}
    for page in records:
        stem = build_page_stem(page)
        page_links[page["prototype_id"]] = {
            "md": f"pages/{stem}.md",
            "html": f"pages/{stem}.html",
        }
    return page_links


def normalize_table_cell(value: str) -> str:
    return value.replace("|", "/").replace("\n", "?")


def build_markdown_full(
    xlsx_path: Path,
    records: list[dict[str, str]],
    page_links: dict[str, dict[str, str]] | None = None,
) -> str:
    grouped = group_by_module(records)
    mermaid = build_mermaid(grouped)

    lines: list[str] = []
    lines.append(f"# {SYSTEM_NAME}??????????????")
    lines.append("")
    lines.append(f"- ????`{xlsx_path.as_posix()}`")
    lines.append(f"- ?????{len(records)}")
    lines.append(f"- ????{len(grouped)}")
    lines.append("")

    lines.append("## ???????")
    lines.append("| ???? | ??? |")
    lines.append("|---|---:|")
    for module, pages in grouped.items():
        lines.append(f"| {module} | {len(pages)} |")
    lines.append("")

    lines.append("## ?????")
    lines.append("```mermaid")
    lines.append(mermaid)
    lines.append("```")
    lines.append("")

    for i, (module, pages) in enumerate(grouped.items(), start=1):
        lines.append(f"## {i}. {module}")
        lines.append("| ???? | ???? | ???? | ?????? | ?????? | ?? | ???? |")
        lines.append("|---|---|---|---|---|---|---|")
        for page in pages:
            preview = "-"
            if page_links:
                target = page_links.get(page["prototype_id"], {}).get("html")
                if target:
                    preview = f"[HTML]({target})"
            lines.append(
                f"| {page['prototype_id']} | {page['page_name']} | {normalize_table_cell(page['carrier'])} | "
                f"{normalize_table_cell(page['functions'])} | {normalize_table_cell(page['layout'])} | "
                f"{normalize_table_cell(page['note'])} | {preview} |"
            )
        lines.append("")

    return "\n".join(lines) + "\n"


def split_list(text: str) -> list[str]:
    raw = re.split(r"[；;\n]+", text)
    items: list[str] = []
    seen: set[str] = set()
    for t in raw:
        s = t.strip()
        if not s:
            continue
        if s not in seen:
            items.append(s)
            seen.add(s)
    return items


def infer_operation_labels(page: dict[str, str]) -> list[str]:
    src_items = split_list(page.get("functions", ""))
    rename = {
        "\u67e5\u8be2": "\u67e5\u8be2\u51ed\u8bc1",
        "\u65b0\u589e\u51ed\u8bc1": "\u65b0\u589e\u51ed\u8bc1",
        "\u4fdd\u5b58\u5e76\u65b0\u589e": "\u4fdd\u5b58\u5e76\u65b0\u589e",
        "\u4fee\u6539": "\u4fee\u6539\u51ed\u8bc1",
        "\u63d2\u5165": "\u63d2\u5165\u51ed\u8bc1",
        "\u5ba1\u6838": "\u5ba1\u6838",
        "\u53cd\u5ba1\u6838": "\u53cd\u5ba1\u6838",
        "\u4e0a\u4f20\u9644\u4ef6": "\u4e0a\u4f20\u9644\u4ef6",
        "\u9644\u5355\u636e\u6570\u91cf": "\u67e5\u770b\u9644\u5355\u636e\u6570\u91cf",
        "\u6253\u5370\u8bbe\u7f6e": "\u6253\u5370\u8bbe\u7f6e",
        "\u6253\u5370": "\u6253\u5370\u51ed\u8bc1",
        "\u5bfc\u51fa": "\u5bfc\u51fa\u51ed\u8bc1",
        "\u56de\u6536\u7ad9\u67e5\u8be2": "\u56de\u6536\u7ad9\u67e5\u8be2",
        "\u8fd8\u539f": "\u8fd8\u539f\u5df2\u5220\u9664\u51ed\u8bc1",
        "\u5f7b\u5e95\u5220\u9664": "\u5f7b\u5e95\u5220\u9664\u51ed\u8bc1",
    }

    # "\u5907\u6ce8" belongs to field information and should not be listed as an operation.
    skip_items = {"\u5907\u6ce8"}
    result: list[str] = []
    seen: set[str] = set()
    for item in src_items:
        if item in skip_items:
            continue
        mapped = rename.get(item, item)
        if mapped not in seen:
            result.append(mapped)
            seen.add(mapped)
    return result


def infer_field_suggestions(page: dict[str, str], operations: list[str]) -> list[str]:
    page_name = page.get("page_name", "")
    carrier = page.get("carrier", "")
    text = page_name + " " + carrier + " " + " ".join(operations)

    if "??" in text:
        return [
            "????",
            "????",
            "??",
            "????",
            "????",
            "????",
            "??",
            "??",
            "????",
        ]

    if "??" in text or "???" in text:
        return [
            "????",
            "????",
            "????",
            "??",
            "??",
            "?????",
        ]

    if "??" in text or "??" in text or "??" in text:
        return [
            "????",
            "????",
            "????",
            "???",
            "???",
            "???",
            "??/??",
        ]

    if "??" in text:
        return [
            "????",
            "????",
            "????",
            "??",
            "??",
            "??",
            "??/????",
        ]

    if "??" in text:
        return [
            "????",
            "????",
            "????",
            "????",
            "????",
            "??/????",
            "????",
        ]

    if "??" in text or "??" in text:
        return [
            "????",
            "???",
            "????",
            "????",
            "??????",
            "????",
            "????",
        ]

    if "??" in text or "??" in text or "????" in text:
        return [
            "????",
            "???",
            "????",
            "????",
            "????",
            "????",
            "????",
        ]

    if "??" in text:
        return [
            "????",
            "???",
            "????",
            "????",
            "????",
            "????",
        ]

    if "??" in text or "??" in text:
        return [
            "????",
            "????",
            "????",
            "????",
            "??/??",
            "??",
        ]

    if "??" in text or "??" in text:
        return [
            "?????",
            "?????",
            "???",
            "????",
            "????",
            "??",
        ]

    return ["??", "??", "??", "??", "??"]


def infer_layout_sections(page: dict[str, str], operations: list[str]) -> list[str]:
    page_id = page.get("prototype_id", "")

    if page_id == "P02":
        return [
            "\u9875\u9762\u5934\u90e8\uff1a\u9875\u9762\u6807\u9898 + \u9875\u9762\u7f16\u53f7",
            "\u67e5\u8be2\u533a\uff1a\u51ed\u8bc1\u7f16\u53f7\u3001\u65e5\u671f\u8303\u56f4\u3001\u4f1a\u8ba1\u79d1\u76ee\u3001\u91d1\u989d\u8303\u56f4\u3001\u5ba1\u6838\u72b6\u6001",
            "\u64cd\u4f5c\u533a\uff1a\u65b0\u589e\u3001\u5bfc\u51fa\u3001\u6253\u5370\u3001\u5ba1\u6838\u3001\u53cd\u5ba1\u6838",
            "\u8868\u683c\u533a\uff1a\u51ed\u8bc1\u5217\u8868",
            "\u7f16\u8f91\u533a\uff1a\u51ed\u8bc1\u8868\u5355 + \u5206\u5f55\u8868\u683c + \u9644\u4ef6\u4e0a\u4f20",
            "\u56de\u6536\u7ad9\u533a\uff1a\u5df2\u5220\u9664\u51ed\u8bc1\u5217\u8868",
        ]

    # fallback based on source layout
    layout_items = re.split(r"[\u3001,，]+", page.get("layout", ""))
    sections: list[str] = ["\u9875\u9762\u5934\u90e8\uff1a\u9875\u9762\u6807\u9898 + \u9875\u9762\u7f16\u53f7"]
    for token in layout_items:
        t = token.strip()
        if t:
            sections.append(t)
    return sections


def infer_page_goal(page: dict[str, str]) -> str:
    carrier = page.get("carrier", "")
    page_name = page.get("page_name", "")
    return f"\u7528\u4e8e{page_name}\u7684\u4e1a\u52a1\u5904\u7406\uff0c\u8986\u76d6{carrier}\u7b49\u529f\u80fd\u3002"


def validate_template_page(page: dict[str, str], operations: list[str]) -> None:
    if page.get("prototype_id") != "P02":
        raise ValueError("Template validation failed: page_id is not P02")
    if page.get("module") != "\u8d22\u52a1\u4e2d\u5fc3":
        raise ValueError("Template validation failed: module is not 财务中心")

    must_ops = [
        "\u67e5\u8be2\u51ed\u8bc1",
        "\u65b0\u589e\u51ed\u8bc1",
        "\u4fdd\u5b58\u5e76\u65b0\u589e",
        "\u4fee\u6539\u51ed\u8bc1",
        "\u63d2\u5165\u51ed\u8bc1",
        "\u5ba1\u6838",
        "\u53cd\u5ba1\u6838",
        "\u4e0a\u4f20\u9644\u4ef6",
        "\u67e5\u770b\u9644\u5355\u636e\u6570\u91cf",
        "\u6253\u5370\u8bbe\u7f6e",
        "\u6253\u5370\u51ed\u8bc1",
        "\u5bfc\u51fa\u51ed\u8bc1",
        "\u56de\u6536\u7ad9\u67e5\u8be2",
        "\u8fd8\u539f\u5df2\u5220\u9664\u51ed\u8bc1",
        "\u5f7b\u5e95\u5220\u9664\u51ed\u8bc1",
    ]

    missing = [x for x in must_ops if x not in operations]
    if missing:
        raise ValueError("Template validation failed: missing operations => " + ", ".join(missing))

    extra = [x for x in operations if x not in must_ops]
    if extra:
        raise ValueError("Template validation failed: extra operations => " + ", ".join(extra))

    if len(operations) != len(must_ops):
        raise ValueError(
            f"Template validation failed: operation count mismatch => got {len(operations)}, expected {len(must_ops)}"
        )

    strong_tokens = ["\u5ba1\u6838", "\u53cd\u5ba1\u6838", "\u56de\u6536\u7ad9"]
    for token in strong_tokens:
        if not any(token in op for op in operations):
            raise ValueError(f"Template validation failed: mandatory token missing => {token}")


def build_template_markdown(page: dict[str, str]) -> str:
    page_id = page.get("prototype_id", "")
    page_name = page.get("page_name", "")
    module = page.get("module", "")
    operations = infer_operation_labels(page)
    fields = infer_field_suggestions(page, operations)
    sections = infer_layout_sections(page, operations)
    goal = infer_page_goal(page)

    validate_template_page(page, operations)

    lines: list[str] = []
    lines.append(f"# {SYSTEM_NAME} - {page_id} {page_name}\u6a21\u677f\u5316\u539f\u578b\u8bf4\u660e")
    lines.append("")
    lines.append(f"- \u7cfb\u7edf\u540d\u79f0\uff1a{SYSTEM_NAME}")
    lines.append(f"- \u9875\u9762\u7f16\u53f7\uff1a{page_id}")
    lines.append(f"- \u9875\u9762\u540d\u79f0\uff1a{page_name}")
    lines.append(f"- \u6240\u5c5e\u6a21\u5757\uff1a{module}")
    lines.append("")

    # 1) 页面布局说明
    lines.append("## 1. \u9875\u9762\u5e03\u5c40\u8bf4\u660e")
    lines.append(f"- \u9875\u9762\u76ee\u6807\uff1a{goal}")
    lines.append("- \u9875\u9762\u529f\u80fd\uff1a")
    for op in operations:
        lines.append(f"  - {op}")
    lines.append(f"- \u5e03\u5c40\u6765\u6e90\u8bf4\u660e\uff1a{page.get('layout','')}")
    lines.append("")

    # 2) 页面结构
    lines.append("## 2. \u9875\u9762\u7ed3\u6784")
    for idx, section in enumerate(sections, start=1):
        lines.append(f"{idx}. {section}")
    lines.append("")

    # 3) 关键字段和操作按钮
    lines.append("## 3. \u5173\u952e\u5b57\u6bb5\u548c\u64cd\u4f5c\u6309\u94ae")
    lines.append("### 3.1 \u5173\u952e\u5b57\u6bb5")
    for f in fields:
        lines.append(f"- {f}")
    lines.append("")
    lines.append("### 3.2 \u64cd\u4f5c\u6309\u94ae")
    for op in operations:
        lines.append(f"- {op}")

    # order validation
    text = "\n".join(lines)
    a = text.find("## 1. \u9875\u9762\u5e03\u5c40\u8bf4\u660e")
    b = text.find("## 2. \u9875\u9762\u7ed3\u6784")
    c = text.find("## 3. \u5173\u952e\u5b57\u6bb5\u548c\u64cd\u4f5c\u6309\u94ae")
    if not (0 <= a < b < c):
        raise ValueError("Template validation failed: section order mismatch")

    return text + "\n"


def build_template_html(page: dict[str, str], md_text: str) -> str:
    operations = infer_operation_labels(page)
    fields = infer_field_suggestions(page, operations)
    sections = infer_layout_sections(page, operations)

    op_html = "".join(f"<li>{html.escape(x)}</li>" for x in operations)
    field_html = "".join(f"<li>{html.escape(x)}</li>" for x in fields)
    section_html = "".join(f"<li>{html.escape(x)}</li>" for x in sections)

    return f"""<!doctype html>
<html lang=\"zh-CN\">
<head>
  <meta charset=\"utf-8\" />
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
  <title>{html.escape(SYSTEM_NAME)} - {html.escape(page.get('prototype_id',''))}</title>
  <style>
    :root {{ --bg:#f6f8fc; --ink:#1f2937; --card:#ffffff; --line:#d6deeb; --brand:#2f5bff; }}
    * {{ box-sizing:border-box; }}
    body {{ margin:0; font-family:\"Microsoft YaHei\",\"PingFang SC\",sans-serif; background:var(--bg); color:var(--ink); }}
    header {{ padding:18px 22px; color:#fff; background:linear-gradient(120deg,#2343b8,#2f5bff); }}
    header h1 {{ margin:0 0 8px; font-size:22px; }}
    main {{ max-width:1100px; margin:18px auto; padding:0 14px 28px; }}
    section {{ background:var(--card); border:1px solid var(--line); border-radius:12px; padding:14px 16px; margin:12px 0; }}
    h2 {{ margin:0 0 10px; font-size:18px; }}
    h3 {{ margin:10px 0 8px; font-size:15px; }}
    ul, ol {{ margin:6px 0 0 20px; }}
    li {{ margin:4px 0; line-height:1.45; }}
    .meta p {{ margin:6px 0; }}
  </style>
</head>
<body>
  <header>
    <h1>{html.escape(SYSTEM_NAME)} - {html.escape(page.get('prototype_id',''))} {html.escape(page.get('page_name',''))}</h1>
  </header>
  <main>
    <section class=\"meta\">
      <p><b>系统名称：</b>{html.escape(SYSTEM_NAME)}</p>
      <p><b>页面编号：</b>{html.escape(page.get('prototype_id',''))}</p>
      <p><b>页面名称：</b>{html.escape(page.get('page_name',''))}</p>
      <p><b>所属模块：</b>{html.escape(page.get('module',''))}</p>
    </section>

    <section>
      <h2>1. 页面布局说明</h2>
      <p><b>页面目标：</b>{html.escape(infer_page_goal(page))}</p>
      <h3>页面功能</h3>
      <ul>{op_html}</ul>
      <p><b>布局来源说明：</b>{html.escape(page.get('layout',''))}</p>
    </section>

    <section>
      <h2>2. 页面结构</h2>
      <ol>{section_html}</ol>
    </section>

    <section>
      <h2>3. 关键字段和操作按钮</h2>
      <h3>3.1 关键字段</h3>
      <ul>{field_html}</ul>
      <h3>3.2 操作按钮</h3>
      <ul>{op_html}</ul>
    </section>
  </main>
</body>
</html>
"""


def build_page_markdown(page: dict[str, str], include_generated_at: bool = False) -> str:
    page_id = page.get("prototype_id", "")
    page_name = page.get("page_name", "")
    module = page.get("module", "")
    operations = infer_operation_labels(page)
    fields = infer_field_suggestions(page, operations)
    sections = infer_layout_sections(page, operations)

    lines: list[str] = []
    lines.append(f"# {SYSTEM_NAME} - {page_id} {page_name} ??????")
    lines.append("")
    lines.append(f"- ?????{SYSTEM_NAME}")
    lines.append(f"- ?????{page_id}")
    lines.append(f"- ?????{page_name}")
    lines.append(f"- ?????{module}")
    if include_generated_at:
        lines.append(f"- ?????{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    lines.append("")

    lines.append("## 1. ??????")
    lines.append(f"- ?????{infer_page_goal(page)}")
    if page.get("carrier"):
        lines.append(f"- ???????{page.get('carrier', '')}")
    lines.append("- ?????")
    for op in operations:
        lines.append(f"  - {op}")
    lines.append(f"- ???????{page.get('layout', '')}")
    if page.get("note"):
        lines.append(f"- ???{page.get('note', '')}")
    lines.append("")

    lines.append("## 2. ????")
    for idx, section in enumerate(sections, start=1):
        lines.append(f"{idx}. {section}")
    lines.append("")

    lines.append("## 3. ?????????")
    lines.append("### 3.1 ????")
    for field in fields:
        lines.append(f"- {field}")
    lines.append("")
    lines.append("### 3.2 ????")
    for op in operations:
        lines.append(f"- {op}")

    return "\n".join(lines) + "\n"


def build_page_html(page: dict[str, str], home_href: str | None = None) -> str:
    operations = infer_operation_labels(page)
    fields = infer_field_suggestions(page, operations)
    sections = infer_layout_sections(page, operations)

    op_html = "".join(f"<li>{html.escape(item)}</li>" for item in operations)
    field_html = "".join(f"<li>{html.escape(item)}</li>" for item in fields)
    section_html = "".join(f"<li>{html.escape(item)}</li>" for item in sections)
    meta_rows = [
        ("????", SYSTEM_NAME),
        ("????", page.get("prototype_id", "")),
        ("????", page.get("page_name", "")),
        ("????", page.get("module", "")),
        ("??????", page.get("carrier", "")),
        ("????", datetime.now().strftime("%Y-%m-%d %H:%M:%S")),
    ]
    meta_html = "".join(
        f"<p><b>{html.escape(label)}?</b>{html.escape(value)}</p>"
        for label, value in meta_rows
        if value
    )
    note_html = ""
    if page.get("note"):
        note_html = (
            "<section>"
            "<h2>4. ????</h2>"
            f"<p>{html.escape(page.get('note', ''))}</p>"
            "</section>"
        )
    home_link_html = ""
    if home_href:
        home_link_html = f'<a class="back-link" href="{html.escape(home_href)}">??????</a>'

    return f"""<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>{html.escape(SYSTEM_NAME)} - {html.escape(page.get('prototype_id',''))} ????</title>
  <style>
    :root {{
      --bg:#eef3f8;
      --ink:#1f2937;
      --muted:#5b6472;
      --card:#ffffff;
      --line:#d6deeb;
      --brand:#1c5d99;
      --brand-2:#44a1a0;
      --chip:#e8f4ff;
    }}
    * {{ box-sizing:border-box; }}
    body {{
      margin:0;
      font-family:"Microsoft YaHei","PingFang SC",sans-serif;
      background:
        radial-gradient(circle at top left, rgba(68,161,160,.15), transparent 28%),
        linear-gradient(180deg, #f7fbff 0%, var(--bg) 100%);
      color:var(--ink);
    }}
    header {{ padding:22px 24px; color:#fff; background:linear-gradient(135deg,var(--brand),#0f3d63 55%, var(--brand-2)); }}
    header h1 {{ margin:10px 0 6px; font-size:26px; }}
    header p {{ margin:0; color:rgba(255,255,255,.86); line-height:1.6; }}
    main {{ max-width:1180px; margin:18px auto; padding:0 14px 28px; }}
    .back-link {{
      display:inline-block;
      color:#fff;
      text-decoration:none;
      padding:8px 12px;
      border:1px solid rgba(255,255,255,.35);
      border-radius:999px;
      background:rgba(255,255,255,.08);
    }}
    .panel-grid {{ display:grid; grid-template-columns:repeat(auto-fit, minmax(280px, 1fr)); gap:14px; }}
    section {{ background:var(--card); border:1px solid var(--line); border-radius:16px; padding:16px 18px; margin:12px 0; box-shadow:0 12px 28px rgba(15,61,99,.06); }}
    h2 {{ margin:0 0 10px; font-size:18px; }}
    h3 {{ margin:10px 0 8px; font-size:15px; }}
    ul, ol {{ margin:6px 0 0 20px; }}
    li {{ margin:4px 0; line-height:1.45; }}
    .meta p {{ margin:6px 0; color:var(--muted); }}
    .chips {{ display:flex; gap:8px; flex-wrap:wrap; margin-top:10px; }}
    .chip {{
      display:inline-flex;
      align-items:center;
      padding:4px 10px;
      border-radius:999px;
      background:var(--chip);
      color:var(--brand);
      font-size:13px;
      font-weight:700;
    }}
  </style>
</head>
<body>
  <header>
    {home_link_html}
    <h1>{html.escape(SYSTEM_NAME)} - {html.escape(page.get('prototype_id',''))} {html.escape(page.get('page_name',''))}</h1>
    <p>{html.escape(infer_page_goal(page))}</p>
  </header>
  <main>
    <div class="panel-grid">
      <section class="meta">{meta_html}</section>
      <section>
        <h2>????</h2>
        <div class="chips">
          <span class="chip">{html.escape(page.get('module', '?????'))}</span>
          <span class="chip">{html.escape(page.get('prototype_id', 'PX'))}</span>
          <span class="chip">{len(operations)} ???</span>
          <span class="chip">{len(fields)} ?????</span>
        </div>
      </section>
    </div>

    <section>
      <h2>1. ??????</h2>
      <p><b>?????</b>{html.escape(infer_page_goal(page))}</p>
      <p><b>???????</b>{html.escape(page.get('carrier',''))}</p>
      <h3>????</h3>
      <ul>{op_html}</ul>
      <p><b>???????</b>{html.escape(page.get('layout',''))}</p>
    </section>

    <section>
      <h2>2. ????</h2>
      <ol>{section_html}</ol>
    </section>

    <section>
      <h2>3. ?????????</h2>
      <h3>3.1 ????</h3>
      <ul>{field_html}</ul>
      <h3>3.2 ????</h3>
      <ul>{op_html}</ul>
    </section>
    {note_html}
  </main>
</body>
</html>
"""


def build_index_html(
    xlsx_path: Path,
    records: list[dict[str, str]],
    page_links: dict[str, dict[str, str]],
) -> str:
    grouped = group_by_module(records)
    module_cards: list[str] = []
    for module, pages in grouped.items():
        page_items = []
        for page in pages:
            link = page_links[page["prototype_id"]]["html"]
            functions = split_list(page.get("functions", ""))
            page_items.append(
                "<li>"
                f"<a href="{html.escape(link)}">{html.escape(page['prototype_id'])} {html.escape(page['page_name'])}</a>"
                f"<span>{html.escape(page.get('carrier', ''))}</span>"
                f"<em>{len(functions)} ????</em>"
                "</li>"
            )
        module_cards.append(
            "<section class="module-card">"
            f"<div class="module-head"><h2>{html.escape(module)}</h2><span>{len(pages)} ?</span></div>"
            f"<ul class="page-list">{''.join(page_items)}</ul>"
            "</section>"
        )

    generated_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return f"""<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>{html.escape(SYSTEM_NAME)} ????</title>
  <style>
    :root {{
      --bg:#edf4f8;
      --ink:#17212b;
      --muted:#5a6978;
      --card:#ffffff;
      --line:#d3dee8;
      --brand:#1c5d99;
      --accent:#44a1a0;
    }}
    * {{ box-sizing:border-box; }}
    body {{
      margin:0;
      font-family:"Microsoft YaHei","PingFang SC",sans-serif;
      color:var(--ink);
      background:
        radial-gradient(circle at top right, rgba(68,161,160,.18), transparent 22%),
        linear-gradient(180deg, #f7fbff 0%, var(--bg) 100%);
    }}
    header {{
      padding:34px 24px 28px;
      color:#fff;
      background:linear-gradient(135deg, #0f3d63 0%, var(--brand) 58%, var(--accent) 100%);
    }}
    header h1 {{ margin:0 0 10px; font-size:30px; }}
    header p {{ margin:0; max-width:900px; color:rgba(255,255,255,.88); line-height:1.65; }}
    main {{ max-width:1240px; margin:0 auto; padding:20px 16px 36px; }}
    .summary {{
      display:grid;
      grid-template-columns:repeat(auto-fit, minmax(220px, 1fr));
      gap:14px;
      margin-top:-22px;
      margin-bottom:16px;
    }}
    .summary-card {{
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      padding:16px 18px;
      box-shadow:0 14px 32px rgba(15,61,99,.08);
    }}
    .summary-card strong {{
      display:block;
      font-size:28px;
      margin-top:6px;
      color:var(--brand);
      word-break:break-word;
    }}
    .module-grid {{
      display:grid;
      grid-template-columns:repeat(auto-fit, minmax(320px, 1fr));
      gap:16px;
    }}
    .module-card {{
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      padding:18px;
      box-shadow:0 16px 36px rgba(15,61,99,.06);
    }}
    .module-head {{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      margin-bottom:12px;
    }}
    .module-head h2 {{ margin:0; font-size:20px; }}
    .module-head span {{
      padding:4px 10px;
      border-radius:999px;
      background:#e8f4ff;
      color:var(--brand);
      font-weight:700;
      font-size:13px;
    }}
    .page-list {{
      list-style:none;
      margin:0;
      padding:0;
      display:flex;
      flex-direction:column;
      gap:10px;
    }}
    .page-list li {{
      border:1px solid var(--line);
      border-radius:14px;
      padding:12px 14px;
      background:#fbfdff;
    }}
    .page-list a {{
      display:block;
      color:var(--brand);
      text-decoration:none;
      font-weight:700;
      margin-bottom:6px;
    }}
    .page-list span {{
      display:block;
      color:var(--muted);
      line-height:1.5;
      font-size:14px;
    }}
    .page-list em {{
      display:block;
      color:var(--accent);
      font-style:normal;
      font-size:12px;
      margin-top:8px;
      font-weight:700;
    }}
  </style>
</head>
<body>
  <header>
    <h1>{html.escape(SYSTEM_NAME)}????</h1>
    <p>?????????????????????????? HTML ??????????????????????</p>
  </header>
  <main>
    <section class="summary">
      <div class="summary-card">???<strong>{html.escape(xlsx_path.as_posix())}</strong></div>
      <div class="summary-card">????<strong>{len(records)}</strong></div>
      <div class="summary-card">????<strong>{len(grouped)}</strong></div>
      <div class="summary-card">????<strong>{html.escape(generated_at)}</strong></div>
    </section>
    <section class="module-grid">
      {''.join(module_cards)}
    </section>
  </main>
</body>
</html>
"""


def load_records_for_template(args: argparse.Namespace, parsed_records: list[dict[str, str]], out_dir: Path) -> list[dict[str, str]]:
    if args.json_source:
        jpath = Path(args.json_source)
        if not jpath.exists():
            raise FileNotFoundError(f"json_source not found: {jpath}")
        data = json.loads(jpath.read_text(encoding="utf-8"))
        return data.get("records", [])

    default_json = out_dir / "\u9875\u9762\u529f\u80fd\u5b57\u5178_\u7ed3\u6784\u5316.json"
    if default_json.exists():
        data = json.loads(default_json.read_text(encoding="utf-8"))
        return data.get("records", [])

    return parsed_records


def main() -> None:
    args = parse_args()
    xlsx_path = Path(args.xlsx)
    out_dir = Path(args.out_dir)

    rows = parse_xlsx_sheet_rows(xlsx_path, SHEET_NAME)
    records = to_records(rows)
    out_dir.mkdir(parents=True, exist_ok=True)

    # Always refresh structured json in dedicated directory.
    json_path = out_dir / "\u9875\u9762\u529f\u80fd\u5b57\u5178_\u7ed3\u6784\u5316.json"
    json_path.write_text(json.dumps({"records": records}, ensure_ascii=False, indent=2), encoding="utf-8")

    if args.mode == "full":
        page_links = build_page_link_map(records)
        md_path = out_dir / "?????_??????????.md"
        html_path = out_dir / "?????_??????????.html"
        index_path = out_dir / "index.html"
        readme_path = out_dir / "README.md"
        pages_dir = out_dir / "pages"
        pages_dir.mkdir(parents=True, exist_ok=True)

        md_path.write_text(build_markdown_full(xlsx_path, records, page_links), encoding="utf-8")
        index_html = build_index_html(xlsx_path, records, page_links)
        html_path.write_text(index_html, encoding="utf-8")
        index_path.write_text(index_html, encoding="utf-8")

        for page in records:
            stem = build_page_stem(page)
            page_md_path = pages_dir / f"{stem}.md"
            page_html_path = pages_dir / f"{stem}.html"
            page_md_path.write_text(build_page_markdown(page, include_generated_at=True), encoding="utf-8")
            page_html_path.write_text(build_page_html(page, home_href="../index.html"), encoding="utf-8")

        readme_path.write_text(
            "
".join(
                [
                    f"# {SYSTEM_NAME}????",
                    "",
                    f"- ????`{xlsx_path.as_posix()}` ??{SHEET_NAME}????",
                    f"- ????{len(records)}",
                    f"- ??? HTML ???{len(records)}",
                    "",
                    "## ????",
                    f"- `{index_path.as_posix()}`",
                    f"- `{md_path.as_posix()}`",
                    f"- `{html_path.as_posix()}`",
                    f"- `{json_path.as_posix()}`",
                    f"- `{pages_dir.as_posix()}`",
                ]
            )
            + "
",
            encoding="utf-8",
        )

        print("mode=full")
        print("records=", len(records))
        print("md=", md_path)
        print("html=", html_path)
        print("index=", index_path)
        print("pages=", pages_dir)
        print("json=", json_path)
        return

    # template-page mode
    template_records = load_records_for_template(args, records, out_dir)
    page = next((r for r in template_records if r.get("prototype_id") == args.page_id), None)
    if page is None:
        raise ValueError(f"Page not found: {args.page_id}")

    md_text = build_template_markdown(page)
    html_text = build_template_html(page, md_text)

    safe_page_name = sanitize_filename_part(page.get("page_name", ""))
    md_name = f"{args.page_id}_{safe_page_name}_\u6a21\u677f\u539f\u578b.md"
    html_name = f"{args.page_id}_{safe_page_name}_\u6a21\u677f\u539f\u578b.html"

    md_path = out_dir / md_name
    html_path = out_dir / html_name

    md_path.write_text(md_text, encoding="utf-8")
    html_path.write_text(html_text, encoding="utf-8")

    print("mode=template-page")
    print("page_id=", args.page_id)
    print("md=", md_path)
    print("html=", html_path)
    print("json=", json_path)


if __name__ == "__main__":
    main()
