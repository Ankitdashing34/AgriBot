# run_all.ps1
# Starts backend and frontend (Chrome) each in their own PowerShell window.

$ScriptDir = Split-Path -Parent $PSScriptRoot
$BackendScript = Join-Path $ScriptDir 'run_backend.ps1'
$FrontendScript = Join-Path $ScriptDir 'run_frontend_chrome.ps1'

Write-Host "Launching backend..."
Start-Process -FilePath 'powershell' -ArgumentList "-NoExit","-File",$BackendScript

Write-Host "Waiting 5 seconds for backend to initialize..."
Start-Sleep -Seconds 5

Write-Host "Launching frontend (Chrome)..."
Start-Process -FilePath 'powershell' -ArgumentList "-NoExit","-File",$FrontendScript

Write-Host "Both processes started. Check the new PowerShell windows for logs." 
