# BROS Workspace Doctrine (Antigravity)

> Source: `policy/workspace-doctrine.md`

## Scope
This repository operates under BROS (Butler Rule-Optimized System) governance.
All agent actions are subject to the rules defined in the `policy/` directory.

## Core Principles
1. **User authority is final** — explicit user instruction overrides all policies.
2. **Default scope** is the workspace root.
3. **Non-destructive by default** — prefer read operations unless mutation is explicitly requested.
4. **Commit attribution required** — every commit must identify the actor.

## Enforcement
- Pre-tool checks: file ownership locking, commit attribution validation
- Post-tool checks: consistency, chronological order, file integrity
- Run via `system/enforcer/orchestrator/Enforcer.ps1` (requires PowerShell Core)

## Platform
- Commit prefix: `AG-` for Antigravity agents
- Hook system: Antigravity Python SDK (PreToolCallDecideHook)
- For Python hook implementation, see `hooks/antigravity/` or BROS deployment guide
