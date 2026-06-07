---
title: Current Structure
last_updated: 2026-06-07
type: state
status: current
---

## Top-level (BROS shell + user content)

17 BROS shell + 1 workspace = 18 top-level entries.
- Hidden config: .agents, .archive, .github, .obsidian, .safe
- Control plane: data, etc, governance, hooks, inbox, lib, policy, ref, SECOND_BRAIN, system, tools, vaults
- User content: workspace

For the full directory tree, see: `Get-ChildItem -Recurse F:\Orrery` (excluding .git/).

## Workspace (target)

8 modules: career, education, inbox, me, pd, research, side-projects, work.

## Recent changes

(append-only)
- 2026-06-07: Initial Orrery structure created (BROS_SYSTEM -> Orrery migration, structure-only).
- 2026-06-07: Applied YAML frontmatter to all .manifest.md and entry-point files; added .agents/ + AGENTS.md to every workspace module; git init.