param(
  [string]$BindHost = "127.0.0.1",
  [int]$Port = 8000
)

$script = Join-Path $PSScriptRoot "run_local_prototype_server.py"
python $script --host $BindHost --port $Port
