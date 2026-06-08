$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

function Invoke-SkepticAnchorHook {
    Write-Host " [Hook] SkepticAnchor: REMINDER - Verify ALL claims with evidence. Do not guess." -ForegroundColor Cyan
}

Invoke-SkepticAnchorHook
