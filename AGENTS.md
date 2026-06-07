---
module: orrery-root
last_updated: 2026-06-07
---

# Orrery (root)

The BROS shell for personal + work + research content. Replaces F:\BROS_SYSTEM\.

## Harness-agnostic

This contract is **harness-agnostic**. It does not depend on any single agent
platform (OpenCode, VS Code Copilot, Antigravity, Cursor, etc.). The contract
applies to any agent operating in the workspace, regardless of how the agent
was invoked.

The current commit prefix convention (per `F:\BUTLER_ROOT\AGENTS.md`) maps
platforms to prefixes: `VSC-` for VS Code, `AG-` for Antigravity, `OC-` for
OpenCode, `U-` for unknown. The Orrery workspace was bootstrapped with
`OC-` (OpenCode) commits; future commits may use any of the above prefixes
depending on the originating platform.

## Top-level structure

Two layers:
1. **BROS shell** (12 root control-plane dirs) - runtime, agent adapters, governance.
2. **Hidden dirs** (6 at root) - cross-platform agent resources, project context, archive, GitHub adapter, Obsidian config, absolute-canon.
3. **workspace/** - 8 user-content modules.

The split mirrors the BROS pattern: shell-level state vs. user-level state.

## Hidden dirs (uniform pattern)

- `.agents/` - cross-platform agent resources
- `.archive/` - global archive
- `.context/` - project-level designator protocol context (see Context protocol below)
- `.github/` - GitHub-specific adapter
- `.obsidian/` - Obsidian vault config
- `.safe/` - absolute-canon content

## Control-plane dirs (BROS shell)

`data/`, `etc/`, `governance/`, `hooks/`, `inbox/`, `lib/`, `policy/`, `ref/`,
`SECOND_BRAIN/`, `system/`, `tools/`, `vaults/` (12 dirs).

## Context protocol

This workspace implements the designator protocol for parallel-agent coordination
as defined in the canonical template at `F:\Bros\opencode\templates\context\README.md`
(version 2026-06-07). Project-level context (per-agent manifests, brain dumps,
todo, etc.) lives in `.context/`. Orrery ships the 9-file stub schema
(`project.md`, `brain_dump.md`, `todo.md`, `backlog.md`, `ideas_tracker.md`,
`changelog.md`, `failure_log.md`, `promotion_queue.md`, `README.md`); full
deployment is pending.

Toolchain exclusion patterns are in `.contextignore` (project root).

The runtime-context subsystem at `system/context/` is **global** context
(identity, user preferences, system map, global_index), distinct from the
project-level `.context/`.

## Path safety

See `policy/OUTPUT_PATH_POLICY.md` for active path-safety rules (read-anywhere,
no secret paths, archive-first).

## Cross-references

- Runtime subsystems: `system/`
- Current state: `system/manifest/structure/current.manifest.md`
- Renames log: `system/manifest/renames.manifest.md`
- Migrations log: `system/manifest/migrations/migrations.manifest.md`
- Workspace: `workspace/`
