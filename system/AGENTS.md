---
module: orrery-system
last_updated: 2026-06-07
---

# system

Runtime subsystems for Orrery: enforcer, scheduler, learner, start, state, context, manifest.

## Structure
- admission/  - Staging for operations requiring review
- context/    - Global runtime context (identity, user preferences, system map, global_index). Distinct from project-level `.context/` (designator protocol surface).
- enforcer/   - Admission control (controllers, orchestrator, sentinel, logs)
- learner/    - Feedback processing and semantic coherence checking
- manifest/   - System-tracking files (renames, migrations, structure)
- scheduler/  - Skill dispatching and trigger evaluation
- start/      - Session lifecycle (adapters, skills, workflows)
- state/      - Dynamic runtime state