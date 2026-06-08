$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

function Invoke-RulesReloadHook {
    Write-Host " [Hook] RulesReload: REMINDER - If task is complex, RE-READ policy files in $BROS\policy" -ForegroundColor Cyan
}

Invoke-RulesReloadHook
