$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

function Invoke-TranscribeHook {
    Write-Host " [Hook] Transcribe: REMINDER - IF audio input detected (media files or speech), execute /transcribe." -ForegroundColor Cyan
}

Invoke-TranscribeHook
