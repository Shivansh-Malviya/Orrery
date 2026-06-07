# BROS — Antigravity Agent Rules

This directory bridges Antigravity agents to the BROS governance control plane.
Antigravity auto-discovers `.agent/rules/` for behavioral instructions.

## How Antigravity reads BROS

Antigravity reads rules from `.agent/rules/` and workflows from `.agent/workflows/`.
These files point to BROS policy definitions.

## Index

| File | Source | Purpose |
|------|--------|---------|
| `workspace-doctrine.md` | `policy/workspace-doctrine.md` | Operating contract |
| `commit-contract.md` | `policy/commit-contract.md` | Mutation protocol |
| `verification-gates.md` | `policy/verification-gates.md` | Quality gates |

## Core Rules (Antigravity)
1. User authority is final.
2. Default operating scope is this workspace.
3. NEVER write to `F:\BUTLER_ROOT` — all work stays within BROS scope.
4. Prefer non-destructive operations unless explicitly asked otherwise.
5. Commit subjects must start with `AG-` prefix for Antigravity agents.
6. Every commit must include actor attribution (`implemented-by` / `reviewed-by`).

## Hooks

Antigravity uses the Python SDK hook system (not `.github/hooks/` JSON files).
PreToolCallDecideHook equivalent: use `policy.deny()` in your agent SDK config, or
enforce via the BROS enforcer scripts run as CI checks.
