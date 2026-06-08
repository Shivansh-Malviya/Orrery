# BROS Policy — AGENTS.md

Platform-agnostic operating contract for this workspace.

## Purpose
This file is the native cross-platform contract for agents operating in BROS.
Use it as a stable baseline across tools that support AGENTS.md-style governance.

## Core Rules
1. User authority is final.
2. Default operating scope is `F:/BROS_SYSTEM`.
3. For meta-tasks (agent/instruction/hook/policy customization), explicit user direction can authorize out-of-scope actions.
4. Prefer non-destructive operations unless user explicitly asks otherwise.
5. NEVER write to `F:/BUTLER_ROOT`.

## Chanakya Prompt Policy
1. Run `promptBoost` first for every Chanakya planning request.
2. If `promptBoost` is unavailable or fails, continue with the original request unchanged and mark `fallback-mode: promptBoost-unavailable`.

## Native Usage Across Platforms
1. Treat `AGENTS.md` as the canonical high-level policy.
2. Keep platform-specific files as adapters that implement this contract.
3. When policies conflict, prefer this order:
   - explicit user instruction
   - `AGENTS.md`
   - platform adapter files
