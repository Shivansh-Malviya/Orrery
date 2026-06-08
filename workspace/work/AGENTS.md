---
module: work
last_updated: 2026-06-07
---
# WorkBrain Workspace

Work-domain memory and execution space. INA engagement: deliverables, projects, profiles, batches.
Only `08_shareable_exports/` is export-safe by default.

## Layout

Subdirectories are created on demand as the module is populated. Conventions:
- Hidden dirs (`.admin/`, `.archive/`, `.profile/`, `.pet-projects/`) follow the uniform pattern.
- All non-conventional content lives under `inbox/` until triaged.

## Knowledge bridge

See `workspace/work/KNOWLEDGE.md` for the domain knowledge index.

## Context surface

- `.context/` — 9-file designator protocol state. Per-agent state, not global.

## Cross-references

- Workspace-level contract: see `F:\Orrery\AGENTS.md`.
- Cross-platform shared resources: `F:\Orrery\.agents\`.
- Runtime subsystems: `F:\Orrery\system\`.
