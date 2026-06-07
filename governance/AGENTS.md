---
module: governance
last_updated: 2026-06-07
---

# governance

Transitional governance layer (mirrors system/ in some BROS architectures).
Admissions, enforcer, hooks, learner, policy, scheduler, start, state.

## Layout

- admission/  - Admission control logic
- context/    - Context subsystem
- enforcer/   - Enforcer scripts
- hooks/      - Hook definitions
- learner/    - Learning/feedback subsystem
- policy/     - Policy hooks
- scheduler/  - Scheduled task definitions
- start/      - Session start logic
- state/      - Runtime state files

## Cross-references

- Workspace root contract: see F:\Orrery\AGENTS.md
- Cross-platform shared: F:\Orrery\.agents\
- Runtime subsystems: F:\Orrery\system\
- Policy: F:\Orrery\policy\