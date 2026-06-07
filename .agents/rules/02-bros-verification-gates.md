> **Historical / platform-specific note:** This is the BROS verification
> gates rule, migrated from `F:\BROS_SYSTEM\.agents\rules\verification-gates.md`
> on 2026-06-07. It references BROS-specific enforcer domains (brain-dump,
> consistency, file-integrity, etc.) and the BROS enforcer orchestrator.
> Orrery does not yet have an enforcer runtime; this file is preserved as
> a reference of the BROS gates and as a future implementation target.

# BROS Verification Gates (Antigravity)

> Source: `policy/verification-gates.md`

## Required Checks
Before claiming work is complete:

1. **Lint** — run the project's linter and fix all issues
2. **Type check** — run type checker (e.g., `mypy`, `tsc --noEmit`)
3. **Tests** — run test suite and confirm all pass
4. **Enforcer sweep** — run `system/enforcer/orchestrator/Enforcer.ps1` to validate system consistency

## Enforcer Domains
| Domain | Controllers | Purpose |
|--------|-------------|---------|
| brain-dump | 2 | Session state coherence |
| consistency | 5 | Chronological order, system integrity |
| file-integrity | 3 | Uncommitted changes, expected files |
| lifecycle | 4 | Bootstrap validation, powershell version |
| registry | 5 | Lock consistency, skill registry integrity |
| semantic | 4 | Context analysis, open-endedness |
| sentinel | 3 | Policy drift detection, stale locks |
| workflow | 4 | Workflow adherence, stage gate compliance |

## Gate Progression
Work must pass gates in order: gate-a → gate-b → gate-c → gate-d → phase-completion.
See `policy/gates/` for gate definitions.
