param(
    [string]$CatalogCsv = "output/finance-api-catalog.csv",
    [string]$OutCsv = "output/finance-regression-cases.csv"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path $CatalogCsv)) {
    throw "Catalog file not found: $CatalogCsv"
}

$catalog = Import-Csv -Path $CatalogCsv
$rows = New-Object System.Collections.Generic.List[object]
$idx = 1

foreach ($ep in $catalog) {
    $baseId = ("VF-API-{0:d4}" -f $idx)
    $idx++

    $rows.Add([PSCustomObject]@{
        case_id            = "$baseId-L1"
        level              = "L1"
        scenario           = "route_exists"
        page               = $ep.page
        method             = $ep.method
        path               = $ep.path
        auto_executable    = "Y"
        expected_rule      = "response_not_path_404"
        request_template   = "{}"
        baseline_source    = "controller"
    }) | Out-Null

    $rows.Add([PSCustomObject]@{
        case_id            = "$baseId-L2P"
        level              = "L2"
        scenario           = "business_positive"
        page               = $ep.page
        method             = $ep.method
        path               = $ep.path
        auto_executable    = "N"
        expected_rule      = "code_0_and_business_assertions"
        request_template   = "refer_interface_doc_or_fixture"
        baseline_source    = "interface+requirements"
    }) | Out-Null

    $rows.Add([PSCustomObject]@{
        case_id            = "$baseId-L2N"
        level              = "L2"
        scenario           = "business_negative"
        page               = $ep.page
        method             = $ep.method
        path               = $ep.path
        auto_executable    = "N"
        expected_rule      = "validation_or_domain_error_not_500"
        request_template   = "missing_required_or_invalid_state"
        baseline_source    = "interface+requirements"
    }) | Out-Null
}

$outDir = Split-Path -Parent $OutCsv
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$rows | Export-Csv -Path $OutCsv -NoTypeInformation -Encoding UTF8
Write-Output "generated=$($rows.Count) file=$OutCsv"
