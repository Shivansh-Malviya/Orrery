---
title: Current Structure
last_updated: 2026-06-07
type: state
status: current
---

## Top-level (BROS shell + user content)

20 top-level entries (excluding `.git/`):
- 6 hidden dirs: `.agents`, `.archive`, `.context`, `.github`, `.obsidian`, `.safe`
- 12 BROS shell dirs: `data`, `etc`, `governance`, `hooks`, `inbox`, `lib`, `policy`, `ref`, `SECOND_BRAIN`, `system`, `tools`, `vaults`
- 1 user-content root: `workspace`
- `AGENTS.md` (root contract), `README.md` (root entry-point)

For the full directory tree, see: `Get-ChildItem -Recurse F:\Orrery` (excluding .git/).

## Workspace

8 modules: career, education, inbox, me, pd, research, side-projects, work.

Each module has its own `AGENTS.md` and `.context/` (designator protocol surface).

## Recent changes

(append-only)
- 2026-06-07: Initial Orrery structure created (BROS_SYSTEM -> Orrery migration).
- 2026-06-07: Applied YAML frontmatter to all .manifest.md and entry-point files; added .agents/ + AGENTS.md to every workspace module; git init.
- 2026-06-07: Migrated 33 real-content files from BROS_SYSTEM (.agents/, archive/, policy/); 12 BROS shell dirs populated with AGENTS.md + .gitkeep.
