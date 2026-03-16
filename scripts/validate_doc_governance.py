from __future__ import annotations

import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def ensure_file(path_str: str, label: str, errors: list[str]) -> None:
    path = ROOT / path_str
    if not path.exists():
        errors.append(f"missing {label}: {path_str}")


def main() -> int:
    errors: list[str] = []
    registry_path = ROOT / "docs" / "doc-registry.json"
    if not registry_path.exists():
        print("missing docs/doc-registry.json")
        return 1

    registry = load_json(registry_path)
    modules = registry.get("modules", [])
    if not modules:
        errors.append("doc-registry.json has no modules")

    for module in modules:
        module_code = module["module_code"]
        manifest_rel = module["manifest"]
        manifest_path = ROOT / manifest_rel
        if not manifest_path.exists():
            errors.append(f"missing manifest for {module_code}: {manifest_rel}")
            continue
        manifest = load_json(manifest_path)

        baselines = manifest.get("baselines", {})
        for key in ("requirements", "api", "data_model"):
            baseline = baselines.get(key)
            if not baseline:
                errors.append(f"{module_code} missing baseline key: {key}")
                continue
            ensure_file(baseline["path"], f"{module_code}.{key}", errors)

        ensure_file(manifest["codebases"]["frontend"], f"{module_code}.frontend", errors)
        ensure_file(manifest["codebases"]["backend"], f"{module_code}.backend", errors)
        ensure_file(manifest["source_of_truth"]["requirements_json"], f"{module_code}.requirements_json", errors)
        ensure_file(manifest["source_of_truth"]["active_baselines"], f"{module_code}.active_baselines", errors)

        for deprecated in manifest.get("deprecated_files", []):
            old_path = ROOT / deprecated["path"]
            replacement_path = ROOT / deprecated["replacement"]
            if not old_path.exists():
                errors.append(f"missing deprecated file: {deprecated['path']}")
            if not replacement_path.exists():
                errors.append(f"missing replacement file: {deprecated['replacement']}")
            sidecar = old_path.with_suffix(old_path.suffix + ".deprecated.json")
            if not sidecar.exists():
                errors.append(f"missing deprecated sidecar: {sidecar.relative_to(ROOT).as_posix()}")

    if errors:
        print("document governance validation failed")
        for error in errors:
            print(f"- {error}")
        return 1

    print("document governance validation passed")
    for module in modules:
        print(f"- {module['module_code']}: active baselines OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())