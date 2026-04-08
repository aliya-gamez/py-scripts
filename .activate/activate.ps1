$ErrorActionPreference = 'Stop'

Write-Host ''

# Get script directory
$scriptDir = $PSScriptRoot
$venvPath = Join-Path $scriptDir '.venv'
$activateScript = Join-Path $venvPath 'Scripts\Activate.ps1'

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
    Write-Host 'Virtual environment not found.' -ForegroundColor Red
    exit 1
}
else {
    Write-Host 'Virtual environment found' -ForegroundColor Green
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

Write-Host ''

python -m pip list

Write-Host ''
Write-Host 'Environment ready.' -ForegroundColor Cyan
Write-Host ''