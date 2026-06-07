---
manifest: system-changelog
type: changelog
last_updated: 2026-06-07
---

# System changelog

Records each logical step (commit) of the initial Orrery state. This is
the system-level changelog; per-project changelogs live in
`.context/changelog.md` (per the designator protocol).

## Initial state (2026-06-07)

The initial state was committed as 9 logical commits, each covering one
concern. Per user direction, the "single commit per logical step" pattern
is preserved here for review.

### Steps

| # | Subject | Files | Hash |
|---|---------|-------|------|
| 0 | Initial commit (LICENSE) | 1 | d2cf7bb |
| 1 | OC-Chore: add .gitignore with BROS conventions | 1 | 15c62fa |
| 2 | OC-Docs: root entry-point docs (AGENTS.md, README.md) | 2 | f7fe1e7 |
| 3 | OC-Docs: agent contract hierarchy (3 scopes) | 10 | 0c2c815 |
| 4 | OC-Docs: system manifest (renames, migrations, structure) | 4 | f243aab |
| 5 | OC-Feat: designator protocol at root (.context/) | 10 | 1a9b0b9 |
| 6 | OC-Feat: designator protocol per module (8 × 9 stubs) | 72 | 3d5fe59 |
| 7 | OC-Feat: protocol stub at root (.agents/Protocols/) | 1 | 34e9695 |
| 8 | OC-Feat: protocol stub per module (8 modules) | 8 | efaebc1 |
| 9 | OC-Docs: additional initial manifests (this file + 3) | 4 | fabee1c |
| 10 | OC-Chore: capture BROS shell structure (12 dirs with root docs) | 12 | a9c4a48 |

**Total: 124 files across 11 commits (1 LICENSE + 9 OC- initial + 1 OC- capture)**

## Conventions

- Commit subjects for agent commits start with `OC-` (OpenCode)
- Commit bodies include why / what / files / verification / risks / follow-up / attribution / collaboration (per `F:\BUTLER_ROOT\AGENTS.md`)
- `OC-Chore:` for tooling/config, `OC-Docs:` for documentation, `OC-Feat:` for new features
- This changelog is updated after each commit series; per-commit hashes are recorded in the Steps table

## Future

The system changelog will record each subsequent commit series (e.g.,
"populate .context/", "implement sync agent", "convert module to workspace").