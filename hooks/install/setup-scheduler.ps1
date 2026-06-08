$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

Write-Host "=== BROS Setup: Windows Task Scheduler ===" -ForegroundColor Cyan
Write-Host "This script creates scheduled tasks for automated enforcement." -ForegroundColor Cyan
Write-Host ""
Write-Host "Defined tasks:" -ForegroundColor Yellow
Write-Host "  1. BROS-DailyEnforcer - Runs daily at 08:00" -ForegroundColor Gray
Write-Host "  2. BROS-WeeklyMetrics - Runs Sunday at 06:00" -ForegroundColor Gray
Write-Host "  3. BROS-WeeklyRegistrySync - Runs Sunday at 07:00" -ForegroundColor Gray
Write-Host ""
Write-Host "NOTE: Requires Administrator privileges." -ForegroundColor Yellow
Write-Host ""
Write-Host "To create tasks manually:" -ForegroundColor Cyan
Write-Host "  schtasks /CREATE /SC DAILY /TN BROS-DailyEnforcer /TR \"pwsh -File $BROS\hooks\scheduled\daily-enforcer-run.ps1\" /ST 08:00 /RL HIGHEST" -ForegroundColor Gray
Write-Host "  schtasks /CREATE /SC WEEKLY /D SUN /TN BROS-WeeklyMetrics /TR \"pwsh -File $BROS\hooks\scheduled\weekly-metrics.ps1\" /ST 06:00 /RL HIGHEST" -ForegroundColor Gray
Write-Host "  schtasks /CREATE /SC WEEKLY /D SUN /TN BROS-WeeklyRegistrySync /TR \"pwsh -File $BROS\hooks\scheduled\weekly-registry-sync.ps1\" /ST 07:00 /RL HIGHEST" -ForegroundColor Gray
