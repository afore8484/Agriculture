@echo off
chcp 65001 >nul
set PY=E:\Python310\python.exe
set SCRIPT=E:\workspaces\Agriculture\prototype\scripts\run_local_prototype_server.py
set ROOT=E:\workspaces\Agriculture\prototype\scripts\figma_crawler\output

if not exist "%PY%" (
  echo [ERROR] Python not found: %PY%
  exit /b 1
)

if not exist "%SCRIPT%" (
  echo [ERROR] Script not found: %SCRIPT%
  exit /b 1
)

if not exist "%ROOT%\index.html" (
  echo [ERROR] Prototype index not found: %ROOT%\index.html
  exit /b 1
)

echo Starting local prototype server in background...
start "prototype-8001" "%PY%" "%SCRIPT%" --host 127.0.0.1 --port 8001 --root "%ROOT%"
echo URL: http://127.0.0.1:8001/
