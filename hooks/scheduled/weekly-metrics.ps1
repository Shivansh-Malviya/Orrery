$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }
$ErrorActionPreference = "Stop"

Write-Host "=== BROS Scheduled: Weekly Metrics ===" -ForegroundColor Cyan
Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Gray

$logPath = "$BROS\system\state\weekly_metrics_log.md"

$enforcerCount = (Get-ChildItem "$BROS\system\enforcer\controllers" -Recurse -Filter "*.ps1").Count
$policyCount = (Get-ChildItem "$BROS\policy\*.md" -File).Count
$hookCount = (Get-ChildItem "$BROS\hooks" -Recurse -Filter "*.ps1").Count
$stateCount = (Get-ChildItem "$BROS\system\state\*.md" -File).Count
$refCount = (Get-ChildItem "$BROS\ref\*.md" -File).Count

$summary = @"
## Weekly Metrics - $(Get-Date -Format 'yyyy-MM-dd HH:mm')

| Metric | Count |
|--------|-------|
| Enforcer Scripts | $enforcerCount |
| Policy Files | $policyCount |
| Hook Scripts | $hookCount |
| State Files | $stateCount |
| Reference Files | $refCount |

"@

Add-Content -Path $logPath -Value $summary
Write-Host "`nMetrics logged:" -ForegroundColor Cyan
Write-Host "  Enforcers: $enforcerCount" -ForegroundColor Gray
Write-Host "  Policies: $policyCount" -ForegroundColor Gray
Write-Host "  Hooks: $hookCount" -ForegroundColor Gray
Write-Host "  State files: $stateCount" -ForegroundColor Gray
Write-Host "  References: $refCount" -ForegroundColor Gray
Write-Host "`nDone." -ForegroundColor Green
