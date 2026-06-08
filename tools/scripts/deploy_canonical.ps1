param(
    [string]$CanonicalRoot = "F:\Bros\opencode\canonical",
    [string]$OrreryRoot = "F:\Orrery"
)

$targets = @(
    "$OrreryRoot",
    "$OrreryRoot\workspace\argos",
    "$OrreryRoot\workspace\career",
    "$OrreryRoot\workspace\education",
    "$OrreryRoot\workspace\inbox",
    "$OrreryRoot\workspace\lattice",
    "$OrreryRoot\workspace\me",
    "$OrreryRoot\workspace\research",
    "$OrreryRoot\workspace\side-projects",
    "$OrreryRoot\workspace\work"
)

$categories = @(
    @{source="rules";    target="rules"},
    @{source="skills";   target="skills"},
    @{source="workflows";target="workflows"},
    @{source="protocols";target="protocols"}
)

foreach ($target in $targets) {
    $agentDir = "$target\.agents"
    if (-not (Test-Path $agentDir)) {
        Write-Warning "SKIP $agentDir (not found)"
        continue
    }

    foreach ($cat in $categories) {
        $srcDir = "$CanonicalRoot\$($cat.source)"
        $dstDir = "$agentDir\$($cat.target)"

        if (-not (Test-Path $srcDir)) {
            Write-Warning "SKIP source $srcDir (not found)"
            continue
        }

        if (-not (Test-Path $dstDir)) {
            $null = New-Item -ItemType Directory -Path $dstDir -Force
        }

        Get-ChildItem -Path $srcDir -File | ForEach-Object {
            $dstFile = "$dstDir\$($_.Name)"
            Copy-Item -Path $_.FullName -Destination $dstFile -Force
            Write-Output "COPY $($_.FullName) -> $dstFile"
        }
    }
}

Write-Output "Deploy complete: $($targets.Count) targets, $($categories.Count) categories"
