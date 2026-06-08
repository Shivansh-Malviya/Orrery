# system/enforcer/ — Runtime Enforcement

Admission control subsystem. Detects and reports policy violations.

## Structure

- `controllers/` — Individual enforcer controllers (one per check type)
- `logs/` — Enforcer run logs
- `orchestrator/` — Orchestration scripts that run all controllers
- `sentinel/` — Continuous monitoring scripts

## Related

- `etc/defaults/enforcer.yaml` — Default threshold configuration
- `governance/context/enforcer.yaml` — Production threshold configuration
- `hooks/pre-commit/` — Pre-commit enforcement hooks
