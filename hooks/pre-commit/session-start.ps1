$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

$raw = [Console]::In.ReadToEnd()

$response = @{
    continue = $true
    systemMessage = "BROS policy active: scope $BROS. User authority is final for explicit meta-tasks."
}

$response | ConvertTo-Json -Compress
exit 0
