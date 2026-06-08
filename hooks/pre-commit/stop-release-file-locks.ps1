$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$raw = [Console]::In.ReadToEnd()
$event = $null
try { $event = $raw | ConvertFrom-Json -Depth 20 } catch { $event = $null }

$sessionId = ""
if ($event -and $event.sessionId) { $sessionId = [string]$event.sessionId }
if (-not $sessionId -and $event -and $event.session_id) { $sessionId = [string]$event.session_id }
if (-not $sessionId -and $event -and $event.conversationId) { $sessionId = [string]$event.conversationId }
if (-not $sessionId -and $event -and $event.conversation_id) { $sessionId = [string]$event.conversation_id }
if (-not $sessionId) { $sessionId = "unknown-session-$env:USERNAME" }

$lockFile = "$BROS\hooks\state\file-locks.json"
if (-not (Test-Path $lockFile)) {
    $resp = @{ continue = $true; systemMessage = "No file lock registry found; nothing to release." }
    $resp | ConvertTo-Json -Compress
    exit 0
}

$lockMap = @{}
try {
    $rawLocks = Get-Content -Path $lockFile -Raw
    if (-not [string]::IsNullOrWhiteSpace($rawLocks)) {
        $obj = $rawLocks | ConvertFrom-Json -Depth 20
        if ($obj) { foreach ($prop in $obj.PSObject.Properties) { $lockMap[$prop.Name] = $prop.Value } }
    }
} catch { $lockMap = @{} }

$next = @{}
foreach ($k in $lockMap.Keys) {
    $owner = ""
    if ($lockMap[$k].owner) { $owner = [string]$lockMap[$k].owner }
    if ($owner -ne $sessionId) { $next[$k] = $lockMap[$k] }
}

$next | ConvertTo-Json -Depth 20 | Set-Content -Path $lockFile -Encoding UTF8

$resp = @{ continue = $true; systemMessage = "Released file locks for session: $sessionId" }
$resp | ConvertTo-Json -Compress
exit 0
