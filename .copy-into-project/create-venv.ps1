$ErrorActionPreference = 'Stop'

Write-Host ''

# Get script directory
$scriptDir = $PSScriptRoot
$projectDir = Split-Path $scriptDir -Parent
$venvPath = Join-Path $projectDir '.venv'
$activateScript = Join-Path $venvPath 'Scripts\Activate.ps1'
$requirementsPath = Join-Path $projectDir 'requirements.txt'

# Python check
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host 'Python not found. Please install to continue.' -ForegroundColor Red
    exit 1
}
else {
    Write-Host 'Python found' -ForegroundColor Green
}

# Virtual Environment creation/check
if (-not (Test-Path $venvPath)) {
    Write-Host 'Virtual environment not found, creating now...' -ForegroundColor Yellow
    python -m venv $venvPath
}
else {
    Write-Host 'Virtual environment found' -ForegroundColor Green
}

# Verify venv exists
if (-not (Test-Path $venvPath)) {
    Write-Host 'Virtual environment failed to create.' -ForegroundColor Red
    exit 1
}

# Activate venv
if (!$env:VIRTUAL_ENV) {
    Write-Host 'Activating virtual environment...' -ForegroundColor Green
    & $activateScript
}
else {
    Write-Host 'Virtual environment already activated' -ForegroundColor Green
}

# Verify activation
if (!$env:VIRTUAL_ENV) {
    Write-Host 'Virtual environment failed to activate.' -ForegroundColor Red
    exit 1
}

# Requirements check
if (!(Test-Path $requirementsPath)) {
    Write-Host 'requirements.txt not found' -ForegroundColor Red
    exit 1
}

# Install dependencies
Write-Host 'Installing dependencies...' -ForegroundColor Green
Write-Host ''

python -m pip install --upgrade pip
python -m pip install -r $requirementsPath

Write-Host ''

python -m pip list

Write-Host ''
Write-Host 'Environment ready.' -ForegroundColor Cyan
Write-Host ''