#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import zipfile
from collections import OrderedDict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any
from xml.etree import ElementTree as ET

NS = {"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}

HEADER_LEVEL1 = "\u4e00\u7ea7\u529f\u80fd"
HEADER_LEVEL2 = "\u4e8c\u7ea7\u529f\u80fd"
HEADER_REMARK = "\u5907\u6ce8"

DEFAULT_KEYWORDS = [
    "\u67e5\u8be2",
    "\u7edf\u8ba1",
    "\u5c55\u793a",
    "\u5bfc\u51fa",
    "\u65b0\u589e",
    "\u4fee\u6539",
    "\u5220\u9664",
    "\u5ba1\u6838",
    "\u5ba1\u6279",
    "\u9884\u8b66",
    "\u63a5\u53e3",
    "\u767b\u5f55",
    "\u62a5\u8868",
    "\u7ba1\u7406",
    "\u7a7f\u900f",
    "\u5730\u56fe",
]

DEFAULT_MODULE_NAME = "\u519c\u7ecf\u4e00\u5f20\u56fe"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Extract functional requirement rows from a DOCX attachment table."
    )
    parser.add_argument("--source", required=True, help="Absolute path to the source .docx file.")
    parser.add_argument(
        "--full-output",
        default="data/requirements/requirements_full.json",
        help="Path to write full requirement records JSON.",
    )
    parser.add_argument(
        "--index-output",
        default="data/requirements/requirements_index.json",
        help="Path to write fast index JSON.",
    )
    parser.add_argument(
        "--module-name",
        default=DEFAULT_MODULE_NAME,
        help="Top-level module name to export as a standalone JSON file.",
    )
    parser.add_argument(
        "--module-output",
        default="data/requirements/nongjing_map_requirements.json",
        help="Path to write standalone module JSON.",
    )
    parser.add_argument(
        "--keywords",
        nargs="*",
        default=DEFAULT_KEYWORDS,
        help="Keyword list for keyword_to_ids index.",
    )
    return parser.parse_args()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def cell_text(cell: ET.Element) -> str:
    parts: list[str] = []
    for text_node in cell.findall(".//w:t", NS):
        if text_node.text:
            parts.append(text_node.text)
    return "".join(parts).strip()


def row_cells(row: ET.Element) -> list[str]:
    cells = row.findall("./w:tc", NS)
    return [cell_text(cell) for cell in cells]


def load_doc_tables(docx_path: Path) -> list[ET.Element]:
    with zipfile.ZipFile(docx_path) as archive:
        xml_bytes = archive.read("word/document.xml")
    root = ET.fromstring(xml_bytes)
    return root.findall(".//w:tbl", NS)


def pick_function_table(tables: list[ET.Element]) -> tuple[int, list[ET.Element], list[str]]:
    if not tables:
        raise ValueError("No table found in document.")

    ranked: list[tuple[int, int, int, list[str], list[ET.Element]]] = []
    for index, table in enumerate(tables):
        rows = table.findall("./w:tr", NS)
        if not rows:
            continue
        header_cells = row_cells(rows[0])
        padded = header_cells + [""] * max(0, 3 - len(header_cells))
        header = padded[:3]
        score = int(
            header[0] == HEADER_LEVEL1
            and header[1] == HEADER_LEVEL2
            and header[2] == HEADER_REMARK
        )
        ranked.append((score, len(rows), index, header, rows))

    if not ranked:
        raise ValueError("Document tables exist, but none have readable rows.")

    ranked.sort(key=lambda item: (item[0], item[1]), reverse=True)
    _, _, table_index, header, selected_rows = ranked[0]
    return table_index, selected_rows, header


def build_records(rows: list[ET.Element], table_index: int) -> list[dict[str, Any]]:
    records: list[dict[str, Any]] = []
    current_level1 = ""
    current_level2 = ""

    for row_no, row in enumerate(rows[1:], start=1):
        source_cells = row_cells(row)
        padded = source_cells + [""] * max(0, 3 - len(source_cells))

        level1_raw = padded[0].strip()
        level2_raw = padded[1].strip()
        remark_raw = padded[2].strip()

        if not any([level1_raw, level2_raw, remark_raw]):
            continue

        if level1_raw:
            current_level1 = level1_raw
            if not level2_raw:
                current_level2 = ""
        if level2_raw:
            current_level2 = level2_raw

        record_id = f"R{len(records) + 1:04d}"
        record = {
            "id": record_id,
            "row_no": row_no,
            "level1_raw": level1_raw,
            "level2_raw": level2_raw,
            "remark_raw": remark_raw,
            "level1_filled": current_level1,
            "level2_filled": level2_raw if level2_raw else current_level2,
            "table_index": table_index,
            "source_cells": source_cells,
        }
        records.append(record)

    return records


def build_module_structures(
    records: list[dict[str, Any]]
) -> tuple[list[dict[str, Any]], dict[str, list[str]], dict[str, list[str]], dict[str, Any]]:
    module_order: list[str] = []
    module_to_ids: dict[str, list[str]] = OrderedDict()
    submodule_to_ids: dict[str, list[str]] = OrderedDict()

    for record in records:
        level1 = record["level1_filled"]
        level2 = record["level2_filled"]
        record_id = record["id"]

        if level1 not in module_to_ids:
            module_to_ids[level1] = []
            module_order.append(level1)
        module_to_ids[level1].append(record_id)

        sub_key = f"{level1}::{level2}"
        if sub_key not in submodule_to_ids:
            submodule_to_ids[sub_key] = []
        submodule_to_ids[sub_key].append(record_id)

    modules: list[dict[str, Any]] = []
    module_summary_by_level1: list[dict[str, Any]] = []

    for level1 in module_order:
        sub_counts: OrderedDict[str, int] = OrderedDict()
        for record in records:
            if record["level1_filled"] != level1:
                continue
            level2 = record["level2_filled"]
            sub_counts[level2] = sub_counts.get(level2, 0) + 1

        submodules = [{"name": name, "count": count} for name, count in sub_counts.items()]
        modules.append(
            {
                "level1": level1,
                "row_count": len(module_to_ids[level1]),
                "submodules": submodules,
            }
        )
        module_summary_by_level1.append(
            {
                "level1": level1,
                "record_count": len(module_to_ids[level1]),
                "level2_count": len(sub_counts),
                "level2_breakdown": [
                    {"level2": name, "record_count": count} for name, count in sub_counts.items()
                ],
            }
        )

    module_summary = {
        "level1_module_count": len(module_order),
        "level2_module_count": len(submodule_to_ids),
        "total_record_count": len(records),
        "by_level1": module_summary_by_level1,
    }
    return modules, module_to_ids, submodule_to_ids, module_summary


def build_keyword_index(records: list[dict[str, Any]], keywords: list[str]) -> dict[str, list[str]]:
    keyword_to_ids: dict[str, list[str]] = OrderedDict()
    clean_keywords = [keyword.strip() for keyword in keywords if keyword.strip()]

    for keyword in clean_keywords:
        keyword_to_ids[keyword] = []

    for record in records:
        record_id = record["id"]
        haystack = " ".join(
            [
                record["level1_filled"],
                record["level2_filled"],
                record["level1_raw"],
                record["level2_raw"],
                record["remark_raw"],
            ]
        )
        for keyword in clean_keywords:
            if keyword in haystack:
                keyword_to_ids[keyword].append(record_id)

    return keyword_to_ids


def build_module_payload(
    records: list[dict[str, Any]],
    module_name: str,
    keywords: list[str],
    source_path: Path,
    source_hash: str,
    extracted_at: str,
    table_header: list[str],
) -> dict[str, Any]:
    module_records = [record for record in records if record["level1_filled"] == module_name]
    submodule_to_ids: dict[str, list[str]] = OrderedDict()

    for record in module_records:
        level2 = record["level2_filled"]
        if level2 not in submodule_to_ids:
            submodule_to_ids[level2] = []
        submodule_to_ids[level2].append(record["id"])

    submodule_summary = [
        {"level2": level2, "record_count": len(ids), "ids": ids}
        for level2, ids in submodule_to_ids.items()
    ]

    return {
        "meta": {
            "source_path": str(source_path),
            "source_sha256": source_hash,
            "extracted_at": extracted_at,
            "table_header": table_header,
            "module_name": module_name,
            "total_records": len(module_records),
            "submodule_count": len(submodule_to_ids),
        },
        "records": module_records,
        "submodule_summary": submodule_summary,
        "submodule_to_ids": submodule_to_ids,
        "keyword_to_ids": build_keyword_index(module_records, keywords),
    }


def write_json(path: Path, payload: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as file:
        json.dump(payload, file, ensure_ascii=False, indent=2)


def main() -> None:
    args = parse_args()
    source_path = Path(args.source).expanduser()
    full_output_path = Path(args.full_output)
    index_output_path = Path(args.index_output)
    module_output_path = Path(args.module_output)

    if not source_path.exists():
        raise FileNotFoundError(f"Source file not found: {source_path}")

    source_hash = sha256_file(source_path)
    extracted_at = datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")

    tables = load_doc_tables(source_path)
    table_index, rows, header = pick_function_table(tables)
    records = build_records(rows, table_index)
    modules, module_to_ids, submodule_to_ids, module_summary = build_module_structures(records)
    keyword_to_ids = build_keyword_index(records, args.keywords)
    module_payload = build_module_payload(
        records=records,
        module_name=args.module_name,
        keywords=args.keywords,
        source_path=source_path,
        source_hash=source_hash,
        extracted_at=extracted_at,
        table_header=header,
    )

    full_payload = {
        "meta": {
            "source_path": str(source_path),
            "source_sha256": source_hash,
            "extracted_at": extracted_at,
            "table_header": header,
        },
        "records": records,
        "modules": modules,
    }

    index_payload = {
        "meta": {
            "source_path": str(source_path),
            "source_sha256": source_hash,
            "extracted_at": extracted_at,
            "total_records": len(records),
        },
        "module_summary": module_summary,
        "module_to_ids": module_to_ids,
        "submodule_to_ids": submodule_to_ids,
        "keyword_to_ids": keyword_to_ids,
    }

    write_json(full_output_path, full_payload)
    write_json(index_output_path, index_payload)
    write_json(module_output_path, module_payload)

    print(f"Source: {source_path}")
    print(f"Full output: {full_output_path}")
    print(f"Index output: {index_output_path}")
    print(f"Module output: {module_output_path}")
    print(f"Records: {len(records)}")
    print(f"Level1 modules: {module_summary['level1_module_count']}")
    print(f"Standalone module: {args.module_name} ({module_payload['meta']['total_records']})")


if __name__ == "__main__":
    main()
