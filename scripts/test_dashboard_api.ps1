param(
    [string]$BaseUrl = "http://127.0.0.1:48080",
    [string]$JarPath = "C:\Users\yll\.codex\worktrees\e2dc\prototype\ruoyi-vue-pro\yudao-server\target\yudao-server.jar",
    [string]$WorkDir = "C:\Users\yll\.codex\worktrees\e2dc\prototype",
    [string]$DbHost = "43.143.232.82",
    [string]$DbPort = "5432",
    [string]$DbName = "village_finance_dev",
    [string]$DbUser = "village_finance",
    [string]$DbPassword = "9AsWSC4h0eq3JwfBzIpY"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Invoke-JsonGet {
    param([Parameter(Mandatory = $true)][string]$Url)
    $args = @(
        "-sS",
        "-m", "15",
        "-H", "Accept: application/json",
        "-w", "`n__STATUS__:%{http_code}",
        $Url
    )
    $rawOutput = (& curl.exe @args 2>&1) -join "`n"
    $statusCode = -1
    $raw = $rawOutput
    $match = [regex]::Match($rawOutput, "__STATUS__:(\d{3})\s*$")
    if ($match.Success) {
        $statusCode = [int]$match.Groups[1].Value
        $raw = $rawOutput.Substring(0, $match.Index).Trim()
    }
    $json = $null
    if ($raw) {
        try {
            $json = $raw | ConvertFrom-Json
        } catch {
        }
    }
    $ok = $statusCode -ge 200 -and $statusCode -lt 500
    $err = $null
    if ($statusCode -eq -1) {
        $err = $rawOutput
    }
    return [PSCustomObject]@{
        ok = $ok
        statusCode = $statusCode
        json = $json
        raw = $raw
        error = $err
    }
}

function Add-CaseResult {
    param(
        [Parameter(Mandatory = $true)][string]$CaseId,
        [Parameter(Mandatory = $true)][string]$Endpoint,
        [Parameter(Mandatory = $true)][bool]$Passed,
        [Parameter(Mandatory = $true)][int]$HttpStatus,
        [Parameter(Mandatory = $true)][string]$Detail
    )
    $script:results += [PSCustomObject]@{
        caseId = $CaseId
        endpoint = $Endpoint
        passed = $Passed
        httpStatus = $HttpStatus
        detail = $Detail
    }
}

function Get-DataCount {
    param($Data)
    if ($null -eq $Data) {
        return 0
    }
    if ($Data -is [string]) {
        return 1
    }
    if ($Data -is [System.Collections.IEnumerable]) {
        return @($Data).Count
    }
    return 1
}

function Get-PropValue {
    param(
        $Obj,
        [Parameter(Mandatory = $true)][string]$Prop,
        [string]$DefaultValue = ""
    )
    if ($null -eq $Obj) {
        return $DefaultValue
    }
    if ($Obj.PSObject -and $Obj.PSObject.Properties[$Prop]) {
        return $Obj.$Prop
    }
    return $DefaultValue
}

$results = @()
$proc = $null

try {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "C:\Program Files\Java\jdk-17\bin\java.exe"
    $logFile = "C:/Users/yll/.codex/worktrees/e2dc/prototype/output/yudao-server.log"
    if (Test-Path $logFile) {
        Remove-Item -Path $logFile -Force
    }
    $pgUrl = "jdbc:postgresql://$DbHost`:$DbPort/${DbName}?currentSchema=village_finance_ops"
    $serverArgs = @(
        "--spring.profiles.active=local",
        "--logging.file.name=$logFile",
        "--spring.datasource.dynamic.primary=master",
        "--spring.datasource.dynamic.datasource.master.url=$pgUrl",
        "--spring.datasource.dynamic.datasource.master.driver-class-name=org.postgresql.Driver",
        "--spring.datasource.dynamic.datasource.master.username=$DbUser",
        "--spring.datasource.dynamic.datasource.master.password=$DbPassword",
        "--spring.datasource.dynamic.datasource.slave.url=$pgUrl",
        "--spring.datasource.dynamic.datasource.slave.driver-class-name=org.postgresql.Driver",
        "--spring.datasource.dynamic.datasource.slave.username=$DbUser",
        "--spring.datasource.dynamic.datasource.slave.password=$DbPassword",
        "--spring.flyway.enabled=false",
        "--yudao.tenant.enable=false",
        "--yudao.security.permit-all-urls[0]=/api/village-finance/**",
        "--yudao.security.permit-all-urls[1]=/api/home/**"
    )
    $psi.Arguments = "-jar `"$JarPath`" " + ($serverArgs -join " ")
    $psi.WorkingDirectory = $WorkDir
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $proc = [System.Diagnostics.Process]::Start($psi)
    if (-not $proc) {
        throw "Failed to start yudao-server process."
    }

    $ready = $false
    $ledgersProbe = $null
    $startupLog = Join-Path $WorkDir "output\\yudao-server.log"
    for ($i = 0; $i -lt 120; $i++) {
        Start-Sleep -Seconds 1
        if ($proc.HasExited) {
            break
        }
        if (Test-Path $startupLog) {
            $started = Select-String -Path $startupLog -Pattern "Tomcat started on port|Started YudaoServerApplication" -Quiet
            if ($started) {
                $ready = $true
                break
            }
        }
    }
    if (-not $ready) {
        throw "Server not ready on $BaseUrl within timeout. Check output/yudao-server.log"
    }

    $ready = $false
    $lastProbe = $null
    for ($i = 0; $i -lt 15; $i++) {
        $ledgersProbe = Invoke-JsonGet "$BaseUrl/api/village-finance/ledgers"
        $lastProbe = $ledgersProbe
        if ($ledgersProbe.ok -and $ledgersProbe.statusCode -eq 200 -and $ledgersProbe.json -and $ledgersProbe.json.code -eq 0) {
            $ready = $true
            break
        }
        Start-Sleep -Seconds 1
    }
    if (-not $ready) {
        $probeDetail = ""
        if ($lastProbe) {
            if ($lastProbe.json) {
                $probeDetail = "status=$($lastProbe.statusCode), body=$($lastProbe.raw)"
            } else {
                $probeDetail = "status=$($lastProbe.statusCode), error=$($lastProbe.error)"
            }
        }
        throw "Server started but /api/village-finance/ledgers is not ready. $probeDetail Check auth/config and output/yudao-server.log"
    }

    $ledgersResp = $ledgersProbe
    if (-not $ledgersResp) {
        $ledgersResp = Invoke-JsonGet "$BaseUrl/api/village-finance/ledgers"
    }
    $ledgerId = $null
    if ($ledgersResp.ok -and $ledgersResp.json -and $ledgersResp.json.code -eq 0 -and (Get-DataCount $ledgersResp.json.data) -gt 0) {
        $ledgerId = [long](@($ledgersResp.json.data)[0].ledgerId)
    } else {
        throw "Unable to resolve ledgerId from /api/village-finance/ledgers"
    }

    $periodsResp = Invoke-JsonGet "$BaseUrl/api/village-finance/periods?ledgerId=$ledgerId"
    $periodId = $null
    if ($periodsResp.ok -and $periodsResp.json -and $periodsResp.json.code -eq 0 -and (Get-DataCount $periodsResp.json.data) -gt 0) {
        $periodId = [long](@($periodsResp.json.data)[0].periodId)
    } else {
        throw "Unable to resolve periodId from /api/village-finance/periods"
    }

    $userId = 0

    $statUrl = "$BaseUrl/api/village-finance/home/stats?ledgerId=$ledgerId&periodId=$periodId&userId=$userId"
    $statResp = Invoke-JsonGet $statUrl
    Add-CaseResult "DASH-STAT-001" "/api/village-finance/home/stats" `
        ($statResp.ok -and $statResp.statusCode -eq 200 -and $statResp.json.code -eq 0) `
        $statResp.statusCode `
        $(if ($statResp.json) { "code=$($statResp.json.code)" } else { $statResp.error })

    $todoResp = Invoke-JsonGet "$BaseUrl/api/village-finance/home/todos?userId=$userId&limit=10"
    Add-CaseResult "DASH-TODO-001" "/api/village-finance/home/todos" `
        ($todoResp.ok -and $todoResp.statusCode -eq 200 -and $todoResp.json.code -eq 0) `
        $todoResp.statusCode `
        $(if ($todoResp.json) { "count=$(Get-DataCount $todoResp.json.data)" } else { $todoResp.error })

    $chartResp = Invoke-JsonGet "$BaseUrl/api/village-finance/home/charts?ledgerId=$ledgerId&periodId=$periodId&months=6"
    Add-CaseResult "DASH-CHART-001" "/api/village-finance/home/charts" `
        ($chartResp.ok -and $chartResp.statusCode -eq 200 -and $chartResp.json.code -eq 0) `
        $chartResp.statusCode `
        $(if ($chartResp.json) { "count=$(Get-DataCount $chartResp.json.data)" } else { $chartResp.error })

    $assetResp = Invoke-JsonGet "$BaseUrl/api/village-finance/home/asset-distribution?ledgerId=$ledgerId"
    Add-CaseResult "DASH-ASSET-001" "/api/village-finance/home/asset-distribution" `
        ($assetResp.ok -and $assetResp.statusCode -eq 200 -and $assetResp.json.code -eq 0) `
        $assetResp.statusCode `
        $(if ($assetResp.json) { "count=$(Get-DataCount $assetResp.json.data)" } else { $assetResp.error })

    $recentResp = Invoke-JsonGet "$BaseUrl/api/village-finance/home/recent-vouchers?ledgerId=$ledgerId&periodId=$periodId&limit=5"
    Add-CaseResult "DASH-VOUCHER-001" "/api/village-finance/home/recent-vouchers" `
        ($recentResp.ok -and $recentResp.statusCode -eq 200 -and $recentResp.json.code -eq 0) `
        $recentResp.statusCode `
        $(if ($recentResp.json) { "count=$(Get-DataCount $recentResp.json.data)" } else { $recentResp.error })

    $progressResp = Invoke-JsonGet "$BaseUrl/api/village-finance/home/progress?ledgerId=$ledgerId&periodId=$periodId"
    Add-CaseResult "DASH-PROGRESS-001" "/api/village-finance/home/progress" `
        ($progressResp.ok -and $progressResp.statusCode -eq 200 -and $progressResp.json.code -eq 0) `
        $progressResp.statusCode `
        $(if ($progressResp.json) { "percent=$(Get-PropValue -Obj $progressResp.json.data -Prop 'percent' -DefaultValue 'n/a')" } else { $progressResp.error })

    $compatStat = Invoke-JsonGet "$BaseUrl/api/home/stats?ledgerId=$ledgerId&periodId=$periodId&userId=$userId"
    $compatStatPassed = $compatStat.ok -and $compatStat.statusCode -eq 200 -and $compatStat.json.code -eq 0 -and `
        (($compatStat.json.data | ConvertTo-Json -Depth 6) -eq ($statResp.json.data | ConvertTo-Json -Depth 6))
    Add-CaseResult "DASH-COMPAT-001" "/api/home/stats" `
        $compatStatPassed `
        $compatStat.statusCode `
        "compare=/api/village-finance/home/stats"

    $compatProgress = Invoke-JsonGet "$BaseUrl/api/home/progress?ledgerId=$ledgerId&periodId=$periodId"
    $compatProgressPassed = $compatProgress.ok -and $compatProgress.statusCode -eq 200 -and $compatProgress.json.code -eq 0 -and `
        (($compatProgress.json.data | ConvertTo-Json -Depth 6) -eq ($progressResp.json.data | ConvertTo-Json -Depth 6))
    Add-CaseResult "DASH-COMPAT-002" "/api/home/progress" `
        $compatProgressPassed `
        $compatProgress.statusCode `
        "compare=/api/village-finance/home/progress"

    $voucherResp = Invoke-JsonGet "$BaseUrl/api/village-finance/vouchers?ledgerId=$ledgerId&pageNum=1&pageSize=10"
    $summaryPassed = $false
    $summaryDetail = "n/a"
    if ($voucherResp.ok -and $voucherResp.statusCode -eq 200 -and $voucherResp.json.code -eq 0) {
        if ((Get-DataCount $voucherResp.json.data) -eq 0) {
            $summaryPassed = $true
            $summaryDetail = "empty-list"
        } else {
            $first = @($voucherResp.json.data)[0]
            $summaryPassed = ($null -ne $first.PSObject.Properties["summary"])
            $summaryDetail = "has-summary-field=$summaryPassed"
        }
    } else {
        $summaryDetail = if ($voucherResp.error) { $voucherResp.error } else { $voucherResp.raw }
    }
    Add-CaseResult "DASH-DEP-001" "/api/village-finance/vouchers" $summaryPassed $voucherResp.statusCode $summaryDetail

    $invalidStat = Invoke-JsonGet "$BaseUrl/api/village-finance/home/stats?ledgerId=$ledgerId&period=2026/03"
    $invalidStatPassed = ($invalidStat.ok -and $invalidStat.json.code -ne 0) -or (-not $invalidStat.ok)
    Add-CaseResult "DASH-STAT-003" "/api/village-finance/home/stats(period invalid)" `
        $invalidStatPassed `
        $invalidStat.statusCode `
        $(if ($invalidStat.json) { "code=$($invalidStat.json.code)" } else { $invalidStat.error })

    $invalidChart = Invoke-JsonGet "$BaseUrl/api/village-finance/home/charts?ledgerId=$ledgerId&period=202603"
    $invalidChartPassed = ($invalidChart.ok -and $invalidChart.json.code -ne 0) -or (-not $invalidChart.ok)
    Add-CaseResult "DASH-CHART-004" "/api/village-finance/home/charts(period invalid)" `
        $invalidChartPassed `
        $invalidChart.statusCode `
        $(if ($invalidChart.json) { "code=$($invalidChart.json.code)" } else { $invalidChart.error })

    $missingTodo = Invoke-JsonGet "$BaseUrl/api/village-finance/home/todos"
    $missingTodoPassed = (-not $missingTodo.ok) -or ($missingTodo.ok -and $missingTodo.json.code -ne 0)
    Add-CaseResult "DASH-TODO-002" "/api/village-finance/home/todos(userId missing)" `
        $missingTodoPassed `
        $missingTodo.statusCode `
        $(if ($missingTodo.json) { "code=$($missingTodo.json.code)" } else { $missingTodo.error })

    $outDir = Join-Path $WorkDir "output"
    if (-not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir | Out-Null
    }
    $csvPath = Join-Path $outDir "dashboard-api-smoke-result.csv"
    $jsonPath = Join-Path $outDir "dashboard-api-smoke-result.json"
    $results | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csvPath
    $results | ConvertTo-Json -Depth 6 | Out-File -FilePath $jsonPath -Encoding UTF8

    $passedCount = @($results | Where-Object { $_.passed }).Count
    $failedCount = @($results | Where-Object { -not $_.passed }).Count
    [PSCustomObject]@{
        total = $results.Count
        passed = $passedCount
        failed = $failedCount
        csv = $csvPath
        json = $jsonPath
    } | ConvertTo-Json -Depth 4
}
finally {
    if ($proc -and -not $proc.HasExited) {
        try {
            $proc.Kill()
            $proc.WaitForExit(5000) | Out-Null
        } catch {
        }
    }
}

