$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

function Invoke-ContextExpansionHook {
    Write-Host " [Hook] ContextExpansion: REMINDER - Expand 'etc', 'e.g.' into full lists. Do not truncate scope." -ForegroundColor Cyan
}

Invoke-ContextExpansionHook
