$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }
$ErrorActionPreference = "Stop"

param([switch]$Silent)

if (-not $Silent) {
    Write-Host "=== BROS Hook Installer ===" -ForegroundColor Cyan
    Write-Host "Installing hooks to .git/hooks/..." -ForegroundColor Cyan
}

$hookSourceDir = "$BROS\hooks\pre-commit"
$gitHookDir = "$BROS\.git\hooks"

if (-not (Test-Path $gitHookDir)) {
    if (-not $Silent) {
        Write-Warning ".git/hooks directory not found at $gitHookDir"
    }
    exit 0
}

$hookFiles = Get-ChildItem $hookSourceDir -Filter "*.ps1" -File
foreach ($hook in $hookFiles) {
    $targetName = $hook.BaseName -replace '^pretool-', '' -replace '^git-', ''
    $targetPath = Join-Path $gitHookDir $targetName

    if ($hook.BaseName -like 'git-*') {
        $targetPath = Join-Path $gitHookDir ($hook.BaseName -replace '^git-', '')
    }

    if (Test-Path $targetPath) {
        if (-not $Silent) { Write-Host "  EXISTS: $targetPath - skipping" -ForegroundColor Yellow }
    }
    else {
        Copy-Item -Path $hook.FullName -Destination $targetPath
        if (-not $Silent) { Write-Host "  INSTALLED: $targetPath" -ForegroundColor Green }
    }
}

if (-not $Silent) { Write-Host "`nDone. $($hookFiles.Count) hooks processed." -ForegroundColor Green }
