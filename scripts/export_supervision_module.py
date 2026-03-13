#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from collections import OrderedDict
from pathlib import Path
from typing import Any

DEFAULT_INPUT = Path("data/requirements/requirements_full.json")
DEFAULT_OUTPUT_FULL = Path("data/requirements/requirements_supervision_full.json")
DEFAULT_OUTPUT_INDEX = Path("data/requirements/requirements_supervision_index.json")
DEFAULT_ACTIVE_SOURCE = Path("data/requirements/active_data_source.json")

MERGED_MODULE_NAME = "\u65b0\u578b\u519c\u4e1a\u7ecf\u8425\u4e3b\u4f53\u8d22\u52a1\u7ecf\u8425\u76d1\u7ba1\u7cfb\u7edf"
TARGET_LEVEL1_TO_TERMINAL = OrderedDict(
    {
        "\u65b0\u578b\u519c\u4e1a\u7ecf\u8425\u4e3b\u4f53\u8d22\u52a1\u7ecf\u8425\u76d1\u7ba1\u7cfb\u7edf-\u4e3b\u4f53\u7aef": "\u4e3b\u4f53\u7aef",
        "\u65b0\u578b\u519c\u4e1a\u7ecf\u8425\u4e3b\u4f53\u8d22\u52a1\u7ecf\u8425\u76d1\u7ba1\u7cfb\u7edf-\u653f\u5e9c\u7aef": "\u653f\u5e9c\u7aef",
        "\u65b0\u578b\u519c\u4e1a\u7ecf\u8425\u4e3b\u4f53\u8d22\u52a1\u7ecf\u8425\u76d1\u7ba1\u7cfb\u7edf-\u91d1\u878d\u7aef": "\u91d1\u878d\u7aef",
    }
)

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
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Export merged supervision module JSON from requirements_full.json."
    )
    parser.add_argument("--input", default=str(DEFAULT_INPUT), help="Input full requirements JSON.")
    parser.add_argument("--output-full", default=str(DEFAULT_OUTPUT_FULL), help="Merged output JSON.")
    parser.add_argument("--output-index", default=str(DEFAULT_OUTPUT_INDEX), help="Merged index JSON.")
    parser.add_argument(
        "--active-source",
        default=str(DEFAULT_ACTIVE_SOURCE),
        help="Path to active data source pointer JSON.",
    )
    return parser.parse_args()


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def save_json(path: Path, payload: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")


def build_keyword_to_ids(records: list[dict[str, Any]]) -> dict[str, list[str]]:
    keyword_to_ids: dict[str, list[str]] = OrderedDict((k, []) for k in DEFAULT_KEYWORDS)
    for record in records:
        record_id = record["id"]
        haystack = " ".join(
            [
                record.get("level1_filled", ""),
                record.get("level2_filled", ""),
                record.get("remark_raw", ""),
                record.get("terminal", ""),
            ]
        )
        for keyword in DEFAULT_KEYWORDS:
            if keyword in haystack:
                keyword_to_ids[keyword].append(record_id)
    return keyword_to_ids


def main() -> None:
    args = parse_args()
    input_path = Path(args.input)
    output_full_path = Path(args.output_full)
    output_index_path = Path(args.output_index)
    active_source_path = Path(args.active_source)

    data = load_json(input_path)
    records = data.get("records", [])

    merged_records: list[dict[str, Any]] = []
    terminal_to_ids: dict[str, list[str]] = OrderedDict(
        (terminal, []) for terminal in TARGET_LEVEL1_TO_TERMINAL.values()
    )
    submodule_to_ids: dict[str, list[str]] = OrderedDict()

    for record in records:
        level1 = record.get("level1_filled", "")
        if level1 not in TARGET_LEVEL1_TO_TERMINAL:
            continue

        terminal = TARGET_LEVEL1_TO_TERMINAL[level1]
        merged = dict(record)
        merged["level1_original"] = level1
        merged["level1_filled"] = MERGED_MODULE_NAME
        merged["terminal"] = terminal
        merged_records.append(merged)

        record_id = merged["id"]
        terminal_to_ids[terminal].append(record_id)

        sub_key = f"{terminal}::{merged.get('level2_filled', '')}"
        if sub_key not in submodule_to_ids:
            submodule_to_ids[sub_key] = []
        submodule_to_ids[sub_key].append(record_id)

    module_summary = {
        "merged_module_name": MERGED_MODULE_NAME,
        "terminal_count": len(terminal_to_ids),
        "total_records": len(merged_records),
        "by_terminal": [
            {
                "terminal": terminal,
                "record_count": len(ids),
            }
            for terminal, ids in terminal_to_ids.items()
        ],
    }

    merged_full_payload = {
        "meta": {
            "source_data_file": str(input_path),
            "source_path": data.get("meta", {}).get("source_path"),
            "source_sha256": data.get("meta", {}).get("source_sha256"),
            "extracted_at": data.get("meta", {}).get("extracted_at"),
            "merged_module_name": MERGED_MODULE_NAME,
            "included_level1": list(TARGET_LEVEL1_TO_TERMINAL.keys()),
            "total_records": len(merged_records),
        },
        "records": merged_records,
    }

    merged_index_payload = {
        "meta": {
            "source_data_file": str(input_path),
            "merged_data_file": str(output_full_path),
            "merged_module_name": MERGED_MODULE_NAME,
            "total_records": len(merged_records),
        },
        "module_summary": module_summary,
        "module_to_ids": {MERGED_MODULE_NAME: [record["id"] for record in merged_records]},
        "terminal_to_ids": terminal_to_ids,
        "submodule_to_ids": submodule_to_ids,
        "keyword_to_ids": build_keyword_to_ids(merged_records),
    }

    active_source_payload = {
        "data_source": str(output_full_path),
        "module_name": MERGED_MODULE_NAME,
        "description": "Thread default data source",
    }

    save_json(output_full_path, merged_full_payload)
    save_json(output_index_path, merged_index_payload)
    save_json(active_source_path, active_source_payload)

    print(f"Input: {input_path}")
    print(f"Merged full output: {output_full_path}")
    print(f"Merged index output: {output_index_path}")
    print(f"Active source pointer: {active_source_path}")
    print(f"Merged records: {len(merged_records)}")
    for terminal, ids in terminal_to_ids.items():
        print(f" - {terminal}: {len(ids)}")


if __name__ == "__main__":
    main()
