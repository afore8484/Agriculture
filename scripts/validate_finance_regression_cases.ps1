param(
    [string]$CatalogCsv = "output/finance-api-catalog.csv",
    [string]$CasesCsv = "output/finance-regression-cases.csv",
    [string]$InterfaceDoc = "docs/village-finance/interface/接口文档.md",
    [string]$OutJson = "output/finance-regression-baseline-validation.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path $CatalogCsv)) { throw "Catalog not found: $CatalogCsv" }
if (-not (Test-Path $CasesCsv)) { throw "Cases not found: $CasesCsv" }

$catalog = Import-Csv -Path $CatalogCsv
$cases = Import-Csv -Path $CasesCsv

$endpointKeys = @{}
foreach ($ep in $catalog) {
    $key = "$($ep.method) $($ep.path)"
    $endpointKeys[$key] = $true
}

$caseMap = @{}
foreach ($c in $cases) {
    $key = "$($c.method) $($c.path)"
    if (-not $caseMap.ContainsKey($key)) {
        $caseMap[$key] = New-Object System.Collections.Generic.HashSet[string]
    }
    $caseMap[$key].Add($c.level + ":" + $c.scenario) | Out-Null
}

$missingCaseEndpoints = @()
foreach ($key in $endpointKeys.Keys) {
    if (-not $caseMap.ContainsKey($key)) {
        $missingCaseEndpoints += $key
        continue
    }
    $required = @("L1:route_exists", "L2:business_positive", "L2:business_negative")
    foreach ($r in $required) {
        if (-not $caseMap[$key].Contains($r)) {
            $missingCaseEndpoints += "$key missing $r"
        }
    }
}

$extraCaseEndpoints = @()
foreach ($key in $caseMap.Keys) {
    if (-not $endpointKeys.ContainsKey($key)) {
        $extraCaseEndpoints += $key
    }
}

$docEndpointCount = 0
if (Test-Path $InterfaceDoc) {
    $docLines = rg -n '(GET|POST|PUT|DELETE|PATCH)\s+/' $InterfaceDoc
    $docEndpointCount = @($docLines).Count
}

$result = [PSCustomObject]@{
    catalog_endpoint_count = @($catalog).Count
    case_count = @($cases).Count
    expected_case_count = @($catalog).Count * 3
    case_count_match_expected = (@($cases).Count -eq (@($catalog).Count * 3))
    missing_case_items = @($missingCaseEndpoints).Count
    extra_case_items = @($extraCaseEndpoints).Count
    interface_doc_endpoint_lines = $docEndpointCount
    interface_doc_gap_vs_catalog = (@($catalog).Count - $docEndpointCount)
    missing_case_examples = @($missingCaseEndpoints | Select-Object -First 20)
    extra_case_examples = @($extraCaseEndpoints | Select-Object -First 20)
}

$outDir = Split-Path -Parent $OutJson
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}
$result | ConvertTo-Json -Depth 5 | Out-File -FilePath $OutJson -Encoding UTF8
$result | ConvertTo-Json -Depth 5
