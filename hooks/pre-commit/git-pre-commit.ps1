$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }
$ErrorActionPreference = "Stop"

Write-Host "`n=== BROS PRE-COMMIT VALIDATION ===" -ForegroundColor Cyan

$stagedFiles = git diff --cached --name-only --diff-filter=ACM
if ($stagedFiles.Count -eq 0) {
    Write-Host "No files staged for commit" -ForegroundColor Yellow
    exit 0
}

Write-Host "`nFiles to commit: $($stagedFiles.Count)" -ForegroundColor Gray
$failures = @()

Write-Host "`n[1] Checking system file consistency..." -ForegroundColor Yellow
$systemFiles = $stagedFiles | Where-Object { $_ -match "^system/" -or $_ -match "^policy/" -or $_ -match "^hooks/" }
if ($systemFiles.Count -gt 0) {
    foreach ($file in $systemFiles) {
        $fullPath = "$BROS\$file"
        if (Test-Path $fullPath) {
            try {
                & "$BROS\system\enforcer\controllers\consistency\enforcer-pre-edit-consistency.ps1" -FilePath $fullPath
                if ($LASTEXITCODE -eq 1) { $failures += "Consistency check failed for $file" }
            }
            catch { Write-Host "  Could not check $file : $_" -ForegroundColor Yellow }
        }
    }
}
else {
    Write-Host "  Skipping (no system files modified)" -ForegroundColor Gray
}

Write-Host "`n[2] Checking chronological order..." -ForegroundColor Yellow
$datedFiles = $stagedFiles | Where-Object { $_ -match "brain_dump\.md" -or $_ -match "changelog\.md" }
if ($datedFiles.Count -gt 0) {
    try {
        $fullPaths = $datedFiles | ForEach-Object { "$BROS\$_" }
        & "$BROS\system\enforcer\controllers\consistency\enforcer-chrono-order.ps1" -Files $fullPaths
        if ($LASTEXITCODE -ne 0) { $failures += "Chronological order violations" }
    }
    catch { $failures += "Chrono order check failed: $_" }
}
else { Write-Host "  Skipping (no dated files modified)" -ForegroundColor Gray }

Write-Host "`n" + "="*60 -ForegroundColor Cyan
if ($failures.Count -eq 0) {
    Write-Host "All pre-commit checks passed" -ForegroundColor Green
    Write-Host "Proceeding with commit..." -ForegroundColor Cyan
    exit 0
}
else {
    Write-Host "COMMIT BLOCKED: $($failures.Count) failure(s)" -ForegroundColor Red
    foreach ($failure in $failures) { Write-Host "  - $failure" -ForegroundColor Red }
    Write-Host "Fix the issues above and try again" -ForegroundColor Yellow
    Write-Host "To bypass: git commit --no-verify" -ForegroundColor Gray
    exit 1
}
