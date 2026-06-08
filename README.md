---
last_updated: 2026-06-07
---

# Orrery

Orrery is a personal agentic operating shell and **OS/control plane** for knowledge work, research, work, and project orchestration.

## Architecture

```text
Orrery root       = OS/control plane
Lattice           = holistic personal knowledge hub / productized knowledge base
ArgOS             = Application Campaign OS, formerly ACOS
WorkBrain         = restricted work-domain second brain
Research          = research domain workspace
second-brain/     = general cross-domain synthesis/map layer, not universal authority
tools/            = tool registry/adapters/shims; tool internals stay native
projects          = independent repos under workspace domains
```

## Harness-agnostic

This repository is **harness-agnostic**. The contract (AGENTS.md hierarchy,
manifest conventions, designator protocol) does not depend on any specific
agent platform. Any agent — OpenCode, VS Code Copilot, Antigravity, Cursor —
operating in this workspace follows the same contract.

## Top-level layout

| Path | Kind | Purpose |
|---|---|---|
| .agents/ | hidden | Cross-platform shared agent resources (rules, skills, workflows) |
| .archive/ | hidden | Global archive (deprecated content) |
| .context/ | hidden | Project-level designator protocol context (per-agent manifests, brain dump, todo, etc.) |
| .github/ | hidden | GitHub-specific adapter (copilot instructions, hooks) |
| .obsidian/ | hidden | Obsidian vault config |
| .safe/ | hidden | Absolute-canon content (publishes/, docs/, locked/) |
| data/ | shell | Structured data files |
| etc/ | shell | Configuration (non-secret) |
| governance/ | shell | Governance records |
| hooks/ | shell | Runtime hooks (enforcer, scheduler) |
| inbox/ | shell | Triage inbox (shell-level, distinct from workspace/inbox/) |
| lib/ | shell | Shared library code |
| policy/ | shell | Policy documents (rules of engagement) |
| ref/ | shell | Reference material |
| second-brain/ | shell | Personal second-brain (shell-level) |
| system/ | shell | Runtime subsystems (enforcer, scheduler, manifest, etc.) |
| tools/ | shell | Operator tools |
| vaults/ | shell | Vault containers (Dendron-style notes; .obsidian/ is preferred) |
| workspace/ | user | 9 user-content modules (career, education, inbox, me, pd, research, side-projects, work) |

**Counts:** 6 hidden + 12 BROS shell + workspace = 19 top-level user-visible entries
(excluding `.git/`).

## Key paths

- `.agents/` internal operating layer
- `.context/` 9-file designator context
- `tools/registry.md` tool routing registry
- `second-brain/` general synthesis/maps
- `workspace/lattice/` holistic personal knowledge hub
- `workspace/argos/` application/campaign OS
- `workspace/work/` restricted WorkBrain
- `workspace/research/`, `workspace/education/`, `workspace/me/`, `workspace/inbox/`, `workspace/side-projects/`
- `workspace/career/` compatibility bridge only

## Getting started

1. Read `AGENTS.md` (this directory's contract).
2. Read `system/AGENTS.md` (runtime subsystems).
3. Read `system/manifest/structure/current.manifest.md` (current state).
4. Read `policy/OUTPUT_PATH_POLICY.md` (path-safety rules).
5. Pick a workspace module and read its `AGENTS.md`.

## Validation

Run `python tools/scripts/validate_structure.py .` after structural changes.

## See also

- `policy/OUTPUT_PATH_POLICY.md` — active path-safety rules
- `system/manifest/changelog.manifest.md` — commit history of the workspace
- `system/manifest/structure/current.manifest.md` — current structure summary
