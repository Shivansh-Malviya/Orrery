$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }
$ErrorActionPreference = "Stop"

Write-Host "=== BROS Scheduled: Daily Enforcer ===" -ForegroundColor Cyan
Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Gray

# Run log rotation before enforcer run
$logRotateScript = "$BROS\system\start\log-rotation.ps1"
if (Test-Path $logRotateScript) { & $logRotateScript -DryRun }

$logPath = "$BROS\system\state\enforcer_daily_log.md"
$controllerDir = "$BROS\system\enforcer\controllers"
$issues = @()

$enforcerScripts = Get-ChildItem $controllerDir -Recurse -Filter "*.ps1" -File | Sort-Object Name
$totalRun = 0
$failedRun = 0

foreach ($script in $enforcerScripts) {
    $relativePath = $script.FullName.Substring($controllerDir.Length - 10)
    Write-Host "`nRunning: $relativePath" -ForegroundColor Yellow
    try {
        & $script.FullName -DryRun
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  PASS" -ForegroundColor Green
        }
        else {
            Write-Host "  FAIL (exit code $LASTEXITCODE)" -ForegroundColor Red
            $failedRun++
            $issues += "$relativePath - exit code $LASTEXITCODE"
        }
    }
    catch {
        Write-Host "  ERROR: $_" -ForegroundColor Red
        $failedRun++
        $issues += "$relativePath - $_"
    }
    $totalRun++
}

$summary = @"
## Daily Enforcer Run - $(Get-Date -Format 'yyyy-MM-dd HH:mm')
- **Status:** $(if ($failedRun -eq 0) { 'ALL PASS' } else { "$failedRun FAILURES" })
- **Total executed:** $totalRun
- **Passed:** $($totalRun - $failedRun)
- **Failed:** $failedRun

$(if ($issues.Count -gt 0) { "### Issues: `n$($issues | ForEach-Object { "- $_" })`n" } else { "" })
"@

Add-Content -Path $logPath -Value $summary
Write-Host "`n=== Daily Enforcer Run Complete: $totalRun scripts, $failedRun failures ===" -ForegroundColor $(if ($failedRun -eq 0) { 'Green' } else { 'Red' })
