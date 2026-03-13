param(
  [string]$BindHost = "127.0.0.1",
  [int]$Port = 8001
)

$pythonExe = "E:\Python310\python.exe"
$script = Join-Path $PSScriptRoot "run_local_prototype_server.py"
$logDir = Join-Path $PSScriptRoot "..\output\local_server"
New-Item -ItemType Directory -Path $logDir -Force | Out-Null
$stdout = Join-Path $logDir "prototype_server_stdout.log"
$stderr = Join-Path $logDir "prototype_server_stderr.log"
$pidFile = Join-Path $logDir "prototype_server.pid"

$argList = "$script --host $BindHost --port $Port"
$p = Start-Process -FilePath $pythonExe -ArgumentList $argList -PassThru -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
$p.Id | Out-File -FilePath $pidFile -Encoding ascii -Force

Start-Sleep -Seconds 1
Write-Output ("Started PID={0} at http://{1}:{2}" -f $p.Id, $BindHost, $Port)
Write-Output "PID file: $pidFile"
Write-Output "Logs: $stdout ; $stderr"
