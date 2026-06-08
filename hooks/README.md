# Hooks

Admission control. Validates before mutation, not after.

## Structure

| Path | Role |
|------|------|
| `pre-commit/` | Pre-commit gates — blocks bad commits with actionable error messages |
| `triggers/` | Event-driven hooks — brain dump updates, context expansion, ideas tracking, rules reload, skeptic anchor, todo sync, transcribe, feedback learning |
| `scheduled/` | Scheduled task definitions — daily enforcer, weekly metrics, setup-scheduler.ps1 |
| `install/` | Hook deployment — install-hooks.ps1 deploys hooks to .git/hooks/ |
