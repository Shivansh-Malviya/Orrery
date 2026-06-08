$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

$raw = [Console]::In.ReadToEnd()
$event = $null
try { $event = $raw | ConvertFrom-Json -Depth 30 }
catch {
    $allow = @{
        hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "allow"; permissionDecisionReason = "Unable to parse hook payload; allowing by fallback policy." }
        continue = $true
    }
    $allow | ConvertTo-Json -Compress
    exit 0
}

function Get-ObjectStrings {
    param([object]$Node)
    $results = @()
    if ($null -eq $Node) { return $results }
    if ($Node -is [string]) { $results += $Node; return $results }
    if ($Node -is [System.Collections.IEnumerable] -and -not ($Node -is [string])) {
        foreach ($item in $Node) { $results += Get-ObjectStrings -Node $item }
        return $results
    }
    $props = $Node.PSObject.Properties
    if ($props) { foreach ($prop in $props) { $results += Get-ObjectStrings -Node $prop.Value } }
    return $results
}

$toolName = ""
if ($event.toolName) { $toolName = [string]$event.toolName }
if (-not $toolName -and $event.tool_name) { $toolName = [string]$event.tool_name }
if (-not $toolName -and $event.name) { $toolName = [string]$event.name }
$toolLower = $toolName.ToLowerInvariant()

$writeLike = @("apply_patch", "create_file", "replace_string_in_file", "multi_replace_string_in_file",
    "mcp_io_github_won_edit_block", "delete_file", "vscode_renamesymbol")

$isWriteTool = $false
foreach ($token in $writeLike) {
    if ($toolLower -like "*$token*") { $isWriteTool = $true; break }
}

if (-not $isWriteTool) {
    $allow = @{
        hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "allow"; permissionDecisionReason = "Non-mutation tool; file ownership guard not required." }
        continue = $true
    }
    $allow | ConvertTo-Json -Compress
    exit 0
}

$allStrings = Get-ObjectStrings -Node $event
$pathCandidates = @()
foreach ($s in $allStrings) {
    if ([string]::IsNullOrWhiteSpace($s)) { continue }
    if ($s -match "^[A-Za-z]:\\" -or $s -match "^F:/" -or $s -match "^F:\\") {
        $pathCandidates += $s
    }
}

$normalizedPaths = @()
foreach ($p in $pathCandidates) {
    try {
        $full = [System.IO.Path]::GetFullPath($p.Replace('/', '\\'))
        if ($full -like "$BROS\\*") { $normalizedPaths += $full }
    } catch { }
}

$normalizedPaths = $normalizedPaths | Select-Object -Unique
if (-not $normalizedPaths -or $normalizedPaths.Count -eq 0) {
    $allow = @{
        hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "allow"; permissionDecisionReason = "No concrete file paths found in tool payload." }
        continue = $true
    }
    $allow | ConvertTo-Json -Compress
    exit 0
}

$sessionId = ""
if ($event.sessionId) { $sessionId = [string]$event.sessionId }
if (-not $sessionId -and $event.session_id) { $sessionId = [string]$event.session_id }
if (-not $sessionId -and $event.conversationId) { $sessionId = [string]$event.conversationId }
if (-not $sessionId -and $event.conversation_id) { $sessionId = [string]$event.conversation_id }
if (-not $sessionId) { $sessionId = "unknown-session-$env:USERNAME" }

$lockFile = "$BROS\hooks\state\file-locks.json"
$lockDir = Split-Path $lockFile -Parent
if (-not (Test-Path $lockDir)) { New-Item -ItemType Directory -Path $lockDir -Force | Out-Null }
if (-not (Test-Path $lockFile)) { "{}" | Set-Content -Path $lockFile -Encoding UTF8 }

$lockMap = @{}
try {
    $rawLocks = Get-Content -Path $lockFile -Raw
    if (-not [string]::IsNullOrWhiteSpace($rawLocks)) {
        $obj = $rawLocks | ConvertFrom-Json -Depth 20
        if ($obj) { foreach ($prop in $obj.PSObject.Properties) { $lockMap[$prop.Name] = $prop.Value } }
    }
} catch { $lockMap = @{} }

$now = [DateTimeOffset]::UtcNow
$ttlMinutes = 120
$conflicts = @()

foreach ($path in $normalizedPaths) {
    $key = $path.ToLowerInvariant()
    $existing = $lockMap[$key]
    if ($null -ne $existing) {
        $owner = ""; $updated = ""
        if ($existing.owner) { $owner = [string]$existing.owner }
        if ($existing.updatedUtc) { $updated = [string]$existing.updatedUtc }
        $active = $false
        if ($updated) {
            try {
                $updatedTs = [DateTimeOffset]::Parse($updated)
                if (($now - $updatedTs).TotalMinutes -le $ttlMinutes) { $active = $true }
            } catch { }
        }
        if ($active -and $owner -and $owner -ne $sessionId) {
            $conflicts += "$path (owned by $owner)"
            continue
        }
    }
    $lockMap[$key] = @{ owner = $sessionId; updatedUtc = $now.ToString("o"); tool = $toolName }
}

if ($conflicts.Count -gt 0) {
    $ask = @{
        hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "ask"; permissionDecisionReason = "Potential concurrent edit detected: " + ($conflicts -join "; ") + ". Confirm before mutating these files." }
        continue = $true
    }
    $ask | ConvertTo-Json -Compress
    exit 0
}

$persist = @{}
foreach ($k in $lockMap.Keys) { $persist[$k] = $lockMap[$k] }
$persist | ConvertTo-Json -Depth 20 | Set-Content -Path $lockFile -Encoding UTF8

$allow = @{
    hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "allow"; permissionDecisionReason = "No active conflicting file ownership detected." }
    continue = $true
}
$allow | ConvertTo-Json -Compress
exit 0
