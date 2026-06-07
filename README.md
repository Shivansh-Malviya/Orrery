---
last_updated: 2026-06-07
---

# Orrery

Personal + work + research workspace. Replaces F:\BROS_SYSTEM\.

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
| SECOND_BRAIN/ | shell | Personal second-brain (shell-level) |
| system/ | shell | Runtime subsystems (enforcer, scheduler, manifest, etc.) |
| tools/ | shell | Operator tools |
| vaults/ | shell | Vault containers (Dendron-style notes; .obsidian/ is preferred) |
| workspace/ | user | 8 user-content modules (career, education, inbox, me, pd, research, side-projects, work) |

**Counts:** 6 hidden + 12 BROS shell + workspace = 19 top-level user-visible entries
(excluding `.git/`).

## Getting started

1. Read `AGENTS.md` (this directory's contract).
2. Read `system/AGENTS.md` (runtime subsystems).
3. Read `system/manifest/structure/current.manifest.md` (current state).
4. Read `policy/OUTPUT_PATH_POLICY.md` (path-safety rules).
5. Pick a workspace module and read its `AGENTS.md`.

## See also

- `policy/OUTPUT_PATH_POLICY.md` — active path-safety rules
- `system/manifest/changelog.manifest.md` — commit history of the workspace
- `system/manifest/structure/current.manifest.md` — current structure summary
