# run_frontend_chrome.ps1
# Launches the Flutter frontend in Chrome in a new PowerShell window.

$RepoRoot = Split-Path -Parent $PSScriptRoot
$FrontendDir = Join-Path $RepoRoot 'frontend\agri_chatbot_app'

Write-Host "Frontend dir: $FrontendDir"

# Ensure flutter is available
flutter --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Flutter is not available on PATH. Install Flutter and add it to PATH before running this script."
    exit 1
}

$launchCmd = "cd `"$FrontendDir`"; flutter run -d chrome"
Start-Process -FilePath 'powershell' -ArgumentList "-NoExit","-Command",$launchCmd
Write-Host "Started Flutter frontend (Chrome) in a new PowerShell window."
