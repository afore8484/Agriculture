param(
    [string]$BaseUrl = "http://127.0.0.1:48080",
    [string]$JarPath = "C:\Users\yll\.codex\worktrees\e2dc\prototype\ruoyi-vue-pro\yudao-server\target\yudao-server.jar",
    [string]$WorkDir = "C:\Users\yll\.codex\worktrees\e2dc\prototype",
    [string]$CatalogCsv = "output/finance-api-catalog.csv",
    [string]$OutCsv = "output/finance-route-regression-result.csv",
    [string]$OutJson = "output/finance-route-regression-result.json",
    [string]$DbHost = "43.143.232.82",
    [string]$DbPort = "5432",
    [string]$DbName = "village_finance_dev",
    [string]$DbUser = "village_finance",
    [string]$DbPassword = "9AsWSC4h0eq3JwfBzIpY"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Invoke-Api {
    param(
        [Parameter(Mandatory = $true)][string]$Method,
        [Parameter(Mandatory = $true)][string]$Url
    )
    $args = @("-sS", "-m", "15", "-X", $Method, "-H", "Accept: application/json")
    if ($Method -in @("POST", "PUT", "PATCH")) {
        $args += @("-H", "Content-Type: application/json", "-d", "{}")
    }
    $args += @("-w", "`n__STATUS__:%{http_code}", $Url)

    $rawOutput = (& curl.exe @args 2>&1) -join "`n"
    $statusCode = -1
    $body = $rawOutput
    $m = [regex]::Match($rawOutput, "__STATUS__:(\d{3})\s*$")
    if ($m.Success) {
        $statusCode = [int]$m.Groups[1].Value
        $body = $rawOutput.Substring(0, $m.Index).Trim()
    }

    $json = $null
    if ($body) {
        try { $json = $body | ConvertFrom-Json } catch { }
    }

    return [PSCustomObject]@{
        status = $statusCode
        body   = $body
        json   = $json
    }
}

if (-not (Test-Path $CatalogCsv)) {
    throw "Catalog not found: $CatalogCsv"
}

$proc = $null
$results = @()
try {
    $logFile = Join-Path $WorkDir "output\\yudao-route-regression.log"
    if (Test-Path $logFile) { Remove-Item $logFile -Force }

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
        "--yudao.security.permit-all-urls[0]=/api/**"
    )

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "C:\Program Files\Java\jdk-17\bin\java.exe"
    $psi.Arguments = "-jar `"$JarPath`" " + ($serverArgs -join " ")
    $psi.WorkingDirectory = $WorkDir
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $proc = [System.Diagnostics.Process]::Start($psi)
    if (-not $proc) {
        throw "Failed to start server process."
    }

    $ready = $false
    for ($i = 0; $i -lt 120; $i++) {
        Start-Sleep -Seconds 1
        if ($proc.HasExited) { break }
        if (Test-Path $logFile) {
            if (Select-String -Path $logFile -Pattern "Tomcat started on port|Started YudaoServerApplication" -Quiet) {
                $ready = $true
                break
            }
        }
    }
    if (-not $ready) {
        throw "Server not ready. Check $logFile"
    }

    $catalog = Import-Csv -Path $CatalogCsv
    foreach ($row in $catalog) {
        $resolvedPath = [regex]::Replace($row.path, "\{[^}]+\}", "1")
        $url = "$BaseUrl$resolvedPath"
        $resp = Invoke-Api -Method $row.method -Url $url

        $code = ""
        $msg = ""
        if ($resp.json) {
            if ($resp.json.PSObject.Properties["code"]) { $code = "$($resp.json.code)" }
            if ($resp.json.PSObject.Properties["msg"]) { $msg = "$($resp.json.msg)" }
            if ($resp.json.PSObject.Properties["message"] -and [string]::IsNullOrWhiteSpace($msg)) {
                $msg = "$($resp.json.message)"
            }
        }
        if ([string]::IsNullOrWhiteSpace($msg) -and $resp.body) {
            $msg = $resp.body
        }
        if ($msg.Length -gt 200) {
            $msg = $msg.Substring(0, 200)
        }

        $routeMissing = $false
        if ($resp.status -eq 404) { $routeMissing = $true }
        if ($resp.body -match "No static resource") { $routeMissing = $true }
        if ($code -eq "404") { $routeMissing = $true }

        $results += [PSCustomObject]@{
            page          = $row.page
            controller    = $row.controller
            method        = $row.method
            path          = $row.path
            resolved_path = $resolvedPath
            http_status   = $resp.status
            app_code      = $code
            passed_route  = (-not $routeMissing) -and ($resp.status -ne -1)
            detail        = $msg
        }
    }

    $outDir = Split-Path -Parent $OutCsv
    if ($outDir -and -not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir | Out-Null
    }
    $results | Export-Csv -Path $OutCsv -NoTypeInformation -Encoding UTF8
    $results | ConvertTo-Json -Depth 5 | Out-File -FilePath $OutJson -Encoding UTF8

    $total = @($results).Count
    $pass = @($results | Where-Object { $_.passed_route }).Count
    $fail = @($results | Where-Object { -not $_.passed_route }).Count
    [PSCustomObject]@{
        total  = $total
        passed = $pass
        failed = $fail
        csv    = $OutCsv
        json   = $OutJson
        log    = $logFile
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
