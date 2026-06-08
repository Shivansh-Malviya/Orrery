---
title: Significant Renames
last_updated: 2026-06-07
type: tracking
status: active
---

Records only SIGNIFICANT renames (e.g., system-level rebrands, fundamental naming-convention changes).
Routine file/dir renames within the same scope are NOT tracked here.

## Entries

### BROS_SYSTEM -> Orrery
- Date: 2026-06-07
- Scope: System-wide
- Reason: Rebuild of BROS_SYSTEM as a clean workspace with harness-agnostic contract. Orrery signals a new direction.
- From: F:\BROS_SYSTEM\
- To: F:\Orrery\

### workspace/pd/ -> workspace/lattice/
- Date: 2026-06-07
- Scope: Workspace module
- Reason: Rename to reflect holistic personal knowledge hub purpose
- From: workspace/pd/
- To: workspace/lattice/

### workspace/career/acos/ -> workspace/argos/
- Date: 2026-06-07
- Scope: Workspace module
- Reason: Extract Application Campaign OS to top-level workspace
- From: workspace/career/acos/
- To: workspace/argos/

### workspace/career/ -> workspace/argos/ (partial) + compatibility bridge
- Date: 2026-06-07
- Scope: Workspace module
- Reason: Split career into canonical argos/ + compatibility bridge at career/
- From: workspace/career/ (deep)
- To: workspace/argos/ (canonical) + workspace/career/ (bridge)

### SECOND_BRAIN/ -> second-brain/
- Date: 2026-06-07
- Scope: Shell directory
- Reason: Lowercase naming convention; add maps/ subdirectory
- From: SECOND_BRAIN/
- To: second-brain/

### .agents/Protocols/ -> .agents/protocols/
- Date: 2026-06-07
- Scope: Hidden dir
- Reason: Lowercase naming convention; merge with .agents/protocols/
- From: .agents/Protocols/
- To: .agents/protocols/

### .agents/AGENTS.md -> .agents/README.md
- Date: 2026-06-07
- Scope: Hidden dir
- Reason: Replace AGENTS.md with README.md per temp structure
- From: .agents/AGENTS.md
- To: .agents/README.md

### vaults/ removed from active tree
- Date: 2026-06-07
- Scope: Shell directory
- Reason: Removed from active tree per temp structure (kept locally per no-replace)
