# BROS Rules for Antigravity

This directory is at `.agents/rules/` — Antigravity's native auto-discovered path for behavioral rules.

## Files

| File | Source policy | Purpose |
|------|--------------|---------|
| `00-bros-workspace-doctrine.md` | `policy/workspace-doctrine.md` | Operating contract |
| `01-bros-commit-contract.md` | `policy/commit-contract.md` | Mutation protocol |
| `02-bros-verification-gates.md` | `policy/verification-gates.md` | Quality gates |
| `03-bros-enforcer-hooks.py` | — | Python PreToolCallDecideHook (file ownership guard) |
| `04-bros-commit-hook.py` | — | Python PreToolCallDecideHook (commit validation) |

## How It Works

Antigravity scans `.agents/rules/` on startup. Each `.md` file's frontmatter
triggers a behavioral rule. Python hooks are registered separately via SDK.

> No deploy step needed — agy reads `.agents/rules/` natively.
