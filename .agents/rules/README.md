> **Historical / platform-specific note:** This README is the BROS
> Antigravity agent-rules index, migrated from
> `F:\BROS_SYSTEM\.agents\rules\README.md` on 2026-06-07. The rule files
> referenced below are BROS-flavored and Antigravity-specific.
> Orrery's active contract is harness-agnostic; see `F:\Orrery\AGENTS.md`.

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
3. **(Historical BROS rule, superseded in Orrery)** "NEVER write to F:\BUTLER_ROOT — all work stays within BROS scope." Orrery's active path-safety policy (see `F:\Orrery\policy\OUTPUT_PATH_POLICY.md`) allows reads of any non-secret path and does not generally forbid writes. The active rule is "no path is forbidden for read-only queries unless it contains secrets."
4. Prefer non-destructive operations unless explicitly asked otherwise.
5. Commit subjects must start with `AG-` prefix for Antigravity agents. (For other platforms, see the multi-platform prefix convention in `F:\BUTLER_ROOT\AGENTS.md`.)
6. Every commit must include actor attribution (`implemented-by` / `reviewed-by`).

## Hooks

Antigravity uses the Python SDK hook system (not `.github/hooks/` JSON files).
PreToolCallDecideHook equivalent: use `policy.deny()` in your agent SDK config, or
enforce via the BROS enforcer scripts run as CI checks.
