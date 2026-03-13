$logDir = Join-Path $PSScriptRoot "..\output\local_server"
$pidFile = Join-Path $logDir "prototype_server.pid"
if (!(Test-Path $pidFile)) {
  Write-Output "No PID file found: $pidFile"
  exit 0
}
$pid = Get-Content -Path $pidFile -ErrorAction SilentlyContinue
if ($pid) {
  Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
  Write-Output "Stopped PID=$pid"
}
Remove-Item -Path $pidFile -Force -ErrorAction SilentlyContinue
