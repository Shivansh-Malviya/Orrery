---
module: hooks
last_updated: 2026-06-07
---

# hooks

Admission control: pre-commit guards, event-driven triggers, scheduled tasks, installers, state.

## Layout

- install/    - Hook installers (install-hooks.ps1, setup-scheduler.ps1)
- pre-commit/ - Pre-commit guard scripts (git, pretool, promptboost, session-start, stop)
- scheduled/  - Scheduled tasks (daily-enforcer-run, weekly-metrics, weekly-registry-sync)
- state/      - Hook state files (file-locks.json); gitignored
- triggers/   - Event-driven triggers (Hook-*.ps1)

## Cross-references

- Workspace root contract: see F:\Orrery\AGENTS.md
- .gitignore: `hooks/state/*` is excluded from version control
- Cross-platform shared: F:\Orrery\.agents\
- File ownership guard: see F:\BUTLER_ROOT\.github\hooks\scripts\pretool-file-ownership-guard.ps1 (canonical BROS implementation; mirror to F:\Orrery\.github\hooks\ if a local copy is needed)