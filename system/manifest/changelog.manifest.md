---
manifest: system-changelog
type: changelog
last_updated: 2026-06-07
---

# System changelog

Records each logical step (commit) of the initial Orrery state. This is
the system-level changelog; per-project changelogs live in
.context/changelog.md (per the designator protocol).

## Initial state (2026-06-07)

The initial state was committed as 9 logical commits, each covering one
concern. Per user direction, the "single commit per logical step" pattern
is preserved here for review.

### Steps

| # | Subject | Files | Hash |
|---|---------|-------|------|
| 1 | OC-Chore: add .gitignore with BROS conventions | 1 | 2f4cc0e |
| 2 | OC-Docs: root entry-point docs (AGENTS.md, README.md) | 2 | ef40f61 |
| 3 | OC-Docs: agent contract hierarchy (3 scopes) | 10 | 4db506d |
| 4 | OC-Docs: system manifest (renames, migrations, structure) | 4 | 45f0eae |
| 5 | OC-Feat: designator protocol at root (.context/) | 10 | 9b18418 |
| 6 | OC-Feat: designator protocol per module (8 × 9 stubs) | 72 | 1647d0e |
| 7 | OC-Feat: protocol stub at root (.agents/Protocols/) | 1 | d876fad |
| 8 | OC-Feat: protocol stub per module (8 modules) | 8 | 11ee3c0 |
| 9 | OC-Docs: additional initial manifests (this file + 3) | 4 | (this commit) |

**Total: 112 files across 9 commits**

## Conventions

- Commit subjects for agent commits start with OC- (OpenCode)
- Commit bodies include why / what / files / verification / risks / follow-up / attribution / collaboration (per F:\BUTLER_ROOT\AGENTS.md)
- OC-Chore: for tooling/config, OC-Docs: for documentation, OC-Feat: for new features
- This changelog is updated after each commit series; per-commit hashes are recorded in the Steps table

## Future

The system changelog will record each subsequent commit series (e.g.,
"populate .context/", "implement sync agent", "convert module to workspace").