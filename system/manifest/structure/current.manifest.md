---
title: Current Structure
last_updated: 2026-06-07
type: state
status: current
---

Orrery uses a federated root architecture.

## OS/control-plane

- `AGENTS.md` (root contract)
- `.agents/` (internal operating layer)
- `.context/` (designator protocol memory/state)
- `system/` (runtime subsystems)
- `policy/` (active policy)
- `governance/` (docs-only governance)
- `hooks/` (event hooks)
- `tools/` (tool registry + adapters)

## Knowledge/product OSes

- `workspace/lattice/` — holistic personal knowledge hub
- `workspace/argos/` — Application Campaign OS
- `workspace/work/` — WorkBrain (restricted)

## Domain workspaces

- `workspace/research/`
- `workspace/education/`
- `workspace/me/`

## Routing workspaces

- `inbox/` (shell-level)
- `workspace/inbox/` (user content)
- `second-brain/` (general synthesis/maps)

## Project namespaces

- `workspace/side-projects/`

## Compatibility surfaces

- `workspace/career/` — only points to `workspace/argos/`

## Deprecated inactive paths

- `workspace/pd/`
- `workspace/career/acos/`
- `SECOND_BRAIN/`
- `.agents/Protocols/`
- `.agents/AGENTS.md`
- `vaults/`

## Top-level inventory (BROS shell + user content)

20 top-level entries (excluding `.git/`):
- 6 hidden dirs: `.agents`, `.archive`, `.context`, `.github`, `.obsidian`, `.safe`
- 12 BROS shell dirs: `data`, `etc`, `governance`, `hooks`, `inbox`, `lib`, `policy`, `ref`, `second-brain`, `system`, `tools`, `vaults`
- 1 user-content root: `workspace`
- `AGENTS.md` (root contract), `README.md` (root entry-point)

For the full directory tree, see: `Get-ChildItem -Recurse F:\Orrery` (excluding .git/).

## Workspace

9 modules: career (bridge), education, inbox, me, research, side-projects, work, lattice, argos.

Each module has its own `AGENTS.md`, `.context/` (designator protocol surface), and `KNOWLEDGE.md` (domain knowledge index).

## Recent changes

(append-only)
- 2026-06-07: Initial Orrery structure created (BROS_SYSTEM -> Orrery migration).
- 2026-06-07: Applied YAML frontmatter to all .manifest.md and entry-point files; added .agents/ + AGENTS.md to every workspace module; git init.
- 2026-06-07: Migrated 33 real-content files from BROS_SYSTEM (.agents/, archive/, policy/); 12 BROS shell dirs populated with AGENTS.md + .gitkeep.
- 2026-06-07: Inherited Orrery_temp skeleton (no-replace): added protocols/, tools/ expansions, governance/ docs, workspace/ restructuring (pd→lattice, career/acos→argos, second-brain rename, etc.).
