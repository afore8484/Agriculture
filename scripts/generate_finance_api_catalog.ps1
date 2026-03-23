param(
    [string]$ControllerDir = "modules/village-finance/backend/src/main/java/com/agriculture/villagefinance/module/finance/controller",
    [string]$OutCsv = "output/finance-api-catalog.csv"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-QuotedStrings {
    param([string]$Text)
    if ([string]::IsNullOrWhiteSpace($Text)) {
        return @()
    }
    $matches = [regex]::Matches($Text, '"([^"]+)"')
    return @($matches | ForEach-Object { $_.Groups[1].Value })
}

function Join-ApiPath {
    param(
        [string]$BasePath,
        [string]$SubPath
    )
    $base = if ($BasePath) { $BasePath.Trim() } else { "" }
    $sub = if ($SubPath) { $SubPath.Trim() } else { "" }
    if ([string]::IsNullOrWhiteSpace($sub) -or $sub -eq "/") {
        return $base
    }
    if ($base.EndsWith("/") -and $sub.StartsWith("/")) {
        return $base + $sub.Substring(1)
    }
    if (-not $base.EndsWith("/") -and -not $sub.StartsWith("/")) {
        return $base + "/" + $sub
    }
    return $base + $sub
}

function Resolve-Page {
    param([string]$Path)
    if ($Path -like "*/home/*" -or $Path -like "/api/home/*") { return "dashboard" }
    if ($Path -like "*/report/*") { return "report-center" }
    if ($Path -like "*/asset/*") { return "asset-management" }
    if ($Path -like "*/contract*") { return "contract-management" }
    if ($Path -like "*/approval*") { return "online-approval" }
    if ($Path -like "*/bank-accounts*" -or $Path -like "*/cash-accounts*" -or $Path -like "*/accounts*" -or $Path -like "*/journals*" -or $Path -like "*/internal-transfers*") { return "fund-management" }
    if ($Path -like "*/vouchers*" -or $Path -like "*/subjects*" -or $Path -like "*/periods*" -or $Path -like "*/period-close*" -or $Path -like "*/ledgers*" -or $Path -like "*/reconciliations*") { return "finance-center" }
    return "unclassified"
}

$rows = New-Object System.Collections.Generic.List[object]
$files = Get-ChildItem -Path $ControllerDir -Filter *.java | Sort-Object Name
foreach ($file in $files) {
    $lines = Get-Content -Path $file.FullName
    $controller = $file.BaseName

    $basePaths = @()
    foreach ($line in $lines) {
        if ($line -match "@RequestMapping\((.+)\)") {
            $basePaths = @(Get-QuotedStrings -Text $Matches[1])
            break
        }
    }
    $basePaths = @($basePaths)
    if ($basePaths.Count -eq 0) {
        $basePaths = @("")
    }

    foreach ($lineRaw in $lines) {
        $line = $lineRaw.Trim()
        if ($line -notmatch "@(GetMapping|PostMapping|PutMapping|DeleteMapping|PatchMapping)(\((.*)\))?") {
            continue
        }
        $httpMethod = $Matches[1].Replace("Mapping", "").ToUpperInvariant()
        $args = if ($Matches.Count -ge 4) { $Matches[3] } else { "" }
        $subPaths = @(Get-QuotedStrings -Text $args)
        $subPaths = @($subPaths)
        if ($subPaths.Count -eq 0) {
            $subPaths = @("")
        }

        foreach ($base in $basePaths) {
            foreach ($sub in $subPaths) {
                $fullPath = Join-ApiPath -BasePath $base -SubPath $sub
                if ([string]::IsNullOrWhiteSpace($fullPath)) {
                    continue
                }
                $rows.Add([PSCustomObject]@{
                    page       = Resolve-Page -Path $fullPath
                    controller = $controller
                    method     = $httpMethod
                    path       = $fullPath
                    source     = $file.FullName
                }) | Out-Null
            }
        }
    }
}

if ($rows.Count -eq 0) {
    throw "No endpoints were extracted."
}

$outDir = Split-Path -Parent $OutCsv
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$uniqueRows = $rows | Sort-Object page, path, method -Unique
$uniqueRows | Export-Csv -Path $OutCsv -NoTypeInformation -Encoding UTF8
Write-Output "generated=$($uniqueRows.Count) file=$OutCsv"
