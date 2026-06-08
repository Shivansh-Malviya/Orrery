# AGENTS.md

Platform-agnostic operating contract for this repository.

## Purpose
This file is the native cross-platform contract for agents operating in this workspace.
Use it as a stable baseline across tools that support AGENTS.md-style governance.

## Core Rules
1. User authority is final.
2. Default operating scope is `F:/BUTLER_ROOT`.
3. For meta-tasks (agent/instruction/hook/policy customization), explicit user direction can authorize out-of-scope actions.
4. Prefer non-destructive operations unless user explicitly asks otherwise.

## Chanakya Prompt Policy
1. Run `promptBoost` first for every Chanakya planning request.
2. Do not gate this on complexity, ambiguity, or any other condition.
3. If `promptBoost` is unavailable or fails, continue with the original request unchanged and mark `fallback-mode: promptBoost-unavailable`.

## Concurrent Edit Safety
Use file ownership locks before mutating files.

Lock protocol:
1. Acquire lock before write-like operations.
2. If another active owner holds the lock, ask before proceeding.
3. Release session locks on session stop.

Lock registry:
- `.github/hooks/state/file-locks.json`

Current enforcement:
- `.github/hooks/scripts/pretool-file-ownership-guard.ps1`
- `.github/hooks/scripts/stop-release-file-locks.ps1`

Note:
- This is a cooperative protocol. It works when participating agents honor the lock checks.

## Commit Attribution Standard
Commit subjects for commits made by VS Code chat agents must start with `VSC-`.

Every commit message must include:
1. why
2. what changed
3. files touched
4. verification performed
5. known risks
6. follow-up actions
7. actor attribution (`implemented-by`, `reviewed-by`, or explicit human/agent identity)
8. collaboration context if concurrent agent activity is possible

## Native Usage Across Platforms
1. Treat `AGENTS.md` as the canonical high-level policy.
2. Keep platform-specific files (`.github/*`, hooks, tool-specific settings) as adapters that implement this contract.
3. When policies conflict, prefer this order:
   - explicit user instruction
   - `AGENTS.md`
   - platform adapter files

## Update Protocol
When updating behavior:
1. Update `AGENTS.md` first.
2. Update platform adapters (`.github/copilot-instructions.md`, `.github/instructions/*`, `.github/hooks/*`) to match.
3. Include a commit message with full attribution and collaboration context.
4. Verify no policy contradiction remains between files.

## MCP Server Usage
When you need external documentation or code examples:

1. **Context7** (`context7`) - Use for official library/framework documentation
   - Trigger: unfamiliar API, library configuration, framework patterns
   - Example: "How to set up authentication with JWT in Express.js" → use context7
   
2. **GitHub Grep** (`gh_grep`) - Use for real-world code examples from GitHub
   - Trigger: need to see how others implement a pattern, best practices in the wild
   - Example: "Show me how developers handle React error boundaries" → use gh_grep

3. **Memory** (`memory`) - Use for project-specific decisions, conventions, and architecture facts
   - Persistent across sessions
   - Store/retrieve key decisions, patterns, and context

4. **Sequential Thinking** (`sequential_thinking`) - Use for complex multi-step reasoning
   - Trigger: complex problem requiring deep analysis and revision
   - Generates hypothesis → verifies → repeats until satisfied
