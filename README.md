---
last_updated: 2026-06-07
---

# Orrery

Structure-only workspace skeleton. Replaces F:\BROS_SYSTEM\.

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
| inbox/ | shell | Triage inbox (BROS-level, distinct from workspace/inbox/) |
| lib/ | shell | Shared library code |
| policy/ | shell | Policy documents (rules of engagement) |
| ref/ | shell | Reference material |
| SECOND_BRAIN/ | shell | Personal second-brain (BROS-level) |
| system/ | shell | Runtime subsystems (enforcer, scheduler, manifest, etc.) |
| tools/ | shell | Operator tools |
| vaults/ | shell | Vault containers (Dendron-style notes; .obsidian/ is preferred) |
| workspace/ | user | 8 user-content modules (career, education, inbox, me, pd, research, side-projects, work) |

## Getting started

1. Read `AGENTS.md` (this directory's contract).
2. Read `system/AGENTS.md` (runtime subsystems).
3. Read `system/manifest/structure/current.manifest.md` (current state).
4. Pick a workspace module and read its `AGENTS.md`.