---
module: orrery-root
last_updated: 2026-06-07
---

# Orrery (root)

The BROS shell for personal + work + research content. Replaces F:\BROS_SYSTEM\.

## Top-level structure

Two layers:
1. **BROS shell** (17 dirs) - control plane, runtime, agent adapters.
2. **workspace/** - 8 user-content modules.

The split mirrors the BROS pattern: shell-level state vs. user-level state.

## Hidden dirs (uniform pattern)

- `.agents/` - cross-platform agent resources
- `.archive/` - global archive
- `.context/` - project-level designator protocol context (see Context protocol below)
- `.github/` - GitHub-specific adapter
- `.obsidian/` - Obsidian vault config
- `.safe/` - absolute-canon content

## Context protocol

This workspace implements the designator protocol for parallel-agent coordination
as defined in `F:\BROS\opencode\templates\context\README.md`. Project-level context
(per-agent manifests, brain dumps, todo, etc.) lives in `.context/`. Orrery ships
the 9-file stub schema (`project.md`, `brain_dump.md`, `todo.md`, `backlog.md`,
`ideas_tracker.md`, `changelog.md`, `failure_log.md`, `promotion_queue.md`,
`README.md`); full deployment is pending.

Toolchain exclusion patterns are in `.contextignore` (project root).

The runtime-context subsystem at `system/context/` is **global** context (identity,
user preferences, system map, global_index), distinct from the project-level
`.context/`.

## Cross-references

- Runtime subsystems: `system/`
- Current state: `system/manifest/structure/current.manifest.md`
- Renames log: `system/manifest/renames.manifest.md`
- Migrations log: `system/manifest/migrations/migrations.manifest.md`
- Workspace: `workspace/`