# Orrery Architecture v1 (Locked)

**Locked on:** 2026-06-09
**Status:** IMMUTABLE — do not edit without governance approval
**Supersedes:** BROS architecture (F:\BROS_SYSTEM\README.md)

This document captures the canonical v1 architecture of the Orrery system.
Any proposed changes must go through the governance lifecycle at `governance/`.

## Key invariants

1. `F:\Orrery` is the active system root
2. `F:\Bros\opencode\canonical\` is the canonical source for protocols/workflows/skills
3. Global user context lives in `.agents/user/`, not `system/context/`
4. Project operational state lives in per-project `.context/`
5. `F:\BROS_SYSTEM` is provenance reference only
