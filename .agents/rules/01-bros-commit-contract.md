# BROS Commit Contract (Antigravity)

> Source: `policy/commit-contract.md`

## Attribution Standard
Every commit message MUST include:
1. **Why** — the motivation or purpose
2. **What changed** — summary of modifications
3. **Files touched** — list of affected paths
4. **Verification performed** — tests, lint, or manual checks
5. **Known risks** — potential side effects
6. **Follow-up actions** — anything left for later
7. **Actor attribution** — `implemented-by` or `reviewed-by` with identity
8. **Collaboration context** — if concurrent agent activity is possible

## Platform Prefix
Commit subjects must start with `AG-` for Antigravity agents.

## Prohibited
- Commits without attribution
- Commits bypassing pre-commit validation
- Direct pushes to protected branches without review
