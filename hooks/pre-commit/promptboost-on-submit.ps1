$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

$raw = [Console]::In.ReadToEnd()

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

$payloadObject = $null
try { $payloadObject = $raw | ConvertFrom-Json -Depth 30 } catch { $payloadObject = $null }

$searchText = $raw
if ($payloadObject) {
    $allStrings = Get-ObjectStrings -Node $payloadObject
    if ($allStrings.Count -gt 0) { $searchText = [string]::Join("`n", $allStrings) }
}

$lower = $searchText.ToLowerInvariant()
$isTrivial = $false

$messageText = ""
if ($payloadObject) {
    if ($payloadObject.message) { $messageText = [string]$payloadObject.message }
    elseif ($payloadObject.req) { $messageText = [string]$payloadObject.req }
    elseif ($payloadObject.text) { $messageText = [string]$payloadObject.text }
}
if ([string]::IsNullOrWhiteSpace($messageText)) { $messageText = $searchText }

$messageLower = $messageText.ToLowerInvariant().Trim()

if ($messageLower -like "*--skip-boost*" -or $messageLower -like "*--no-boost*") { $isTrivial = $true }
elseif ($messageLower -match '^\s*(thanks|thank\s+you|ok|okay|done|complete|sure|yes|no|yep|nope|got\s+it|cool|great)[\.\!?]*\s*$') { $isTrivial = $true }

$response = @{ continue = $true }
if (-not $isTrivial) {
    $response.systemMessage = "PromptBoost activated. Optimizing your prompt for clarity and completeness."
}

$response | ConvertTo-Json -Compress
exit 0
