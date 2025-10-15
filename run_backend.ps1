# run_backend.ps1
# Creates a venv (if needed), installs requirements, and launches the backend in a new PowerShell window.

# Resolve paths
$RepoRoot = Split-Path -Parent $PSScriptRoot
$BackendDir = Join-Path $RepoRoot 'backend'

Write-Host "Backend dir: $BackendDir"

# Ensure Python is available
python --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Python is not available on PATH. Please install Python 3.10+ and try again."
    exit 1
}

# Create virtual environment if it doesn't exist
$VenvDir = Join-Path $BackendDir '.venv'
if (-Not (Test-Path $VenvDir)) {
    Write-Host "Creating virtual environment at $VenvDir..."
    python -m venv $VenvDir
}

# Install requirements (use system pip to avoid execution-policy activation issues)
Write-Host "Installing Python dependencies..."
python -m pip install --upgrade pip
python -m pip install -r (Join-Path $BackendDir 'requirements.txt')

# Launch the backend in a new PowerShell window so it keeps running
$launchCmd = "cd `"$BackendDir`"; python app.py"
Start-Process -FilePath 'powershell' -ArgumentList "-NoExit","-Command",$launchCmd
Write-Host "Started backend in a new PowerShell window."
