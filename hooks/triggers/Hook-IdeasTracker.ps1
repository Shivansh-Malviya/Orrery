$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

function Invoke-IdeasTrackerHook {
    param(
        [string]$IdeaText,
        [string]$Source = "User",
        [string]$Status = "PENDING"
    )

    Write-Host "Hook-IdeasTracker: Agent-side idea detection template" -ForegroundColor Cyan
    Write-Host "TRIGGER CONDITIONS:" -ForegroundColor Gray
    Write-Host "  - User says: 'I have an idea', 'what if we', 'suggestion:', 'new approach'" -ForegroundColor Gray
    Write-Host "  - Agent proposes: 'Here's an idea', 'We could implement', 'Consider adding'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "AGENT BEHAVIOR:" -ForegroundColor Gray
    Write-Host "  1. Detect idea mention" -ForegroundColor Gray
    Write-Host "  2. Extract: Source, Idea summary, Status (PENDING by default)" -ForegroundColor Gray
    Write-Host "  3. Check ideas_tracker.md for duplicate" -ForegroundColor Gray
    Write-Host "  4. If new, add entry with next ID" -ForegroundColor Gray
    Write-Host "  5. Update ideas_tracker.md" -ForegroundColor Gray
    Write-Host ""
    Write-Host "IDEA FORMAT: | I-XXX | YYYY-MM-DD | Source | Idea summary | PENDING | Notes |" -ForegroundColor Yellow
}

Invoke-IdeasTrackerHook
