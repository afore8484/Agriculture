$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

Write-Host "[恢复检查] 工作目录: $root" -ForegroundColor Cyan

$files = @(
  "docs/day1/shutdown_snapshot_2026-03-06.md",
  "data/requirements/shutdown_checkpoint_2026-03-06.json",
  "data/requirements/nongjing-map/nongjing_map_requirements.json",
  "docs/day1/prototype/nongjing_one_map_modules_zh.html",
  "docs/day1/prototype/finance_f1_f6_wireframe_zh.html"
)

Write-Host "[恢复检查] 关键文件状态:" -ForegroundColor Cyan
foreach ($f in $files) {
  if (Test-Path $f) {
    $item = Get-Item $f
    Write-Host ("  OK  {0} ({1} bytes)" -f $f, $item.Length) -ForegroundColor Green
  } else {
    Write-Host ("  MISS {0}" -f $f) -ForegroundColor Red
  }
}

Write-Host "`n[待完成模块]" -ForegroundColor Yellow
@(
  "资产一张图 -> docs/day1/prototype/asset_one_map_zh.html",
  "资源一张图 -> docs/day1/prototype/resource_one_map_zh.html",
  "合同一张图 -> docs/day1/prototype/contract_one_map_zh.html",
  "成员一张图 -> docs/day1/prototype/member_one_map_zh.html",
  "股权一张图 -> docs/day1/prototype/equity_one_map_zh.html",
  "预警监督   -> docs/day1/prototype/warning_supervision_zh.html"
) | ForEach-Object { Write-Host ("  - " + $_) }

Write-Host "`n[关键约束]" -ForegroundColor Yellow
@(
  "GIS为横切能力，不独立成F7主题",
  "页面全中文，严格显示二级模块名称",
  "不重复建表"
) | ForEach-Object { Write-Host ("  - " + $_) }

Write-Host "`n恢复完成。你可以从总览页开始继续：docs/day1/prototype/nongjing_one_map_modules_zh.html" -ForegroundColor Cyan

