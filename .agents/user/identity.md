---
module: orrery
layer: user-context
purpose: system identity, philosophy, and operating principles
last_updated: 2026-06-09
---

# Orrery — System Identity

Orrery is a personal agentic operating shell — an OS/control plane for knowledge
work, research, career, and project orchestration. It is the successor to BROS
(Brain Operating System).

## Philosophy

1. **Harness-agnostic.** The contract (AGENTS.md hierarchy, designator protocol,
   manifest conventions) does not depend on any agent platform. Any agent —
   OpenCode, VS Code Copilot, Antigravity, Cursor — operating in this workspace
   follows the same contract.

2. **Shell, not a monolith.** Orrery is a control plane. Domain agents (ArgOS,
   Lattice, WorkBrain, ScienceClaw) own their domains. Root is OS, not workspace.

3. **Designator protocol over file locks.** Parallel-agent coordination uses
   session manifests with claimed-items and heartbeat, not file-level locking.
   Cooperative, not mandatory.

4. **Global identity, local state.** System context (identity, preferences, map,
    index) lives in `.agents/user/`. Project operational state lives in per-project
   `.context/`. Promotion queue bridges local → global.

5. **Canonical source, deployed copies.** `F:\Bros\opencode\canonical\` is the
   single source of truth for protocols, workflows, skills, and rules. Each
   Orrery `.agents/` subtree deploys from there.

## Origin

Orrery was bootstrapped from BROS (F:\BROS_SYSTEM) via the BROS Migration plan
(F:\BUTLER_ROOT\00_SYSTEM\BROS_MIGRATION\). BROS phases B0–B3 are complete.
B4 (system test, cutover) is pending. F:\BROS_SYSTEM remains as provenance
reference; Orrery is the live system.

## Key principles

- User authority is final
- Non-destructive operations preferred
- Prompt optimization (Chanakya prompt boost) before planning
- Verifiable claims: evidence before assertion
- Commit attribution: `OC-` (OpenCode), `AG-` (Antigravity), `VSC-` (VS Code), `U-` (unknown)
- Session manifests for parallel agent coordination (see designator protocol)
- Everything is a cooperative protocol, not a mandatory enforcer
