# hooks

Admission control: pre-commit guards, event-driven triggers, scheduled tasks, installers, state.

## Structure
- install/    - Hook installers (install-hooks.ps1, setup-scheduler.ps1)
- pre-commit/ - Pre-commit guard scripts (git, pretool, promptboost, session-start, stop)
- scheduled/  - Scheduled tasks (daily-enforcer-run, weekly-metrics, weekly-registry-sync)
- state/      - Hook state files (file-locks.json)
- triggers/   - Event-driven triggers (Hook-*.ps1)
