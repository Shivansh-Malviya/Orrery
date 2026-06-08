$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

$raw = [Console]::In.ReadToEnd()
$payload = $raw
$lower = $payload.ToLowerInvariant()

$looksLikeCommit = $lower -match "git\s+commit"
$hasAttribution = $lower -match "implemented-by|reviewed-by|co-authored-by|by\s*:"

$platformPrefix = "U"
if ($env:OPENCODE_TRAJECTORY_ID -or $env:OPENCODE_APP_ROOT -or ($env:AGENT_NAME -match "(?i)opencode")) {
    $platformPrefix = "OC"
}
elseif ($env:ANTIGRAVITY_TRAJECTORY_ID -or $env:ANTIGRAVITY_EDITOR_APP_ROOT) {
    $platformPrefix = "AG"
}
elseif ($env:VSCODE_PID) {
    $platformPrefix = "VSC"
}

$hasCorrectPrefix = $payload -match "(?i)git\s+commit[^\r\n]*-m\s+.*\b${platformPrefix}-"

if ($looksLikeCommit -and (-not $hasAttribution -or -not $hasCorrectPrefix)) {
    $reasonParts = @()
    if (-not $hasAttribution) { $reasonParts += "missing actor attribution (implemented-by/reviewed-by)" }
    if (-not $hasCorrectPrefix) { $reasonParts += "commit subject should start with ${platformPrefix}- for this platform" }
    $reason = [string]::Join("; ", $reasonParts)

    $response = @{
        hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "allow"; permissionDecisionReason = "Commit guard advisory: $reason" }
        continue = $true
    }
    $response | ConvertTo-Json -Compress
    exit 0
}

$allow = @{
    hookSpecificOutput = @{ hookEventName = "PreToolUse"; permissionDecision = "allow"; permissionDecisionReason = "Commit guard checks passed." }
    continue = $true
}
$allow | ConvertTo-Json -Compress
exit 0
