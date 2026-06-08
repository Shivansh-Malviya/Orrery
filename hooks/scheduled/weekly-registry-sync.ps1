$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }
$ErrorActionPreference = "Stop"

Write-Host "=== BROS Scheduled: Registry Sync ===" -ForegroundColor Cyan

$registrySyncPath = "$BROS\system\enforcer\controllers\registry\enforcer-registry-sync.ps1"
if (Test-Path $registrySyncPath) {
    & $registrySyncPath -AutoFix
}
else {
    Write-Host "Registry sync script not found at $registrySyncPath" -ForegroundColor Yellow
}

Write-Host "Done." -ForegroundColor Green
