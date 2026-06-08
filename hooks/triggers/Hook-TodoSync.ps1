$BROS = $env:BROS_SYSTEM; if (-not $BROS) { Write-Error "BROS_SYSTEM environment variable not set"; exit 1 }

function Sync-Todos {
    Write-Host "Scanning brain_dump.md for new TODOs..." -ForegroundColor Cyan

    $BrainDumpPath = "$BROS\system\context\brain_dump.md"
    $TodoPath = "$BROS\system\state\todo.md"

    if (-not (Test-Path $BrainDumpPath)) { Write-Host "Brain Dump not found"; return }
    if (-not (Test-Path $TodoPath)) { Write-Host "todo.md not found"; return }

    $content = Get-Content $BrainDumpPath
    $newTodos = @()

    foreach ($line in $content) {
        if ($line -match "^(.*)TODO:\s*(.*)$") {
            $task = $matches[2].Trim()
            $todoContent = Get-Content $TodoPath -Raw
            if ($todoContent -notmatch [regex]::Escape($task)) {
                $newTodos += "- [ ] $task (from Brain Dump)"
            }
        }
    }

    if ($newTodos.Count -gt 0) {
        Write-Host "Found $($newTodos.Count) new tasks. Appending to todo.md..." -ForegroundColor Yellow
        $todoContent = Get-Content $TodoPath -Raw
        if ($todoContent -match "## Inbox") {
            $todoContent = $todoContent -replace "## Inbox", "## Inbox`n$($newTodos -join "`n")"
            Set-Content -Path $TodoPath -Value $todoContent
        }
        else {
            Add-Content -Path $TodoPath -Value "`n## Inbox"
            Add-Content -Path $TodoPath -Value ($newTodos -join "`n")
        }
        Write-Host "Synced $($newTodos.Count) items." -ForegroundColor Green
    }
    else {
        Write-Host "No new unique TODOs found." -ForegroundColor Gray
    }
}

Sync-Todos
