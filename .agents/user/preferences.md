---
module: orrery
layer: user-context
purpose: user preferences and operating style
last_updated: 2026-06-09
---

# User Preferences

## Communication style

- **Conciseness preferred.** Short, direct answers. No preamble, no postamble.
  One-word answers fine for simple questions. No unnecessary explanation.
- **No emojis** unless explicitly requested.
- **Markdown formatting** for structured responses.
- **Evidence before assertions.** State the method and confidence level with any metric.

## Work style

- **Parallel delegation preferred.** Dispatch independent work to subagents concurrently.
- **Non-destructive by default.** Read-only exploration first, mutations only when asked.
- **Prompt optimization.** Chanakya prompt boost before planning work.
- **Explicit planning for multi-step tasks.** Writing plans before touching code.
- **Test-driven development** when implementing features or bugfixes.

## System preferences

- **Hidden directories for agent surfaces.** `.context/` (dot-prefixed) for agent-internal
  state, following Antigravity and OpenCode conventions.
- **File ownership locks** before mutating operations (cooperative protocol).
- **Commit attribution** with platform prefixes (`OC-`, `AG-`, `VSC-`, `U-`).
- **Commit messages** include: why, what changed, files, verification, risks, follow-up, actor.
- **Documentation on request only.** Do not create README or doc files unless asked.

## Technical environment

- **Platform:** Windows (PowerShell 5.1)
- **Shell constraints:** Use `; if ($?) { }` for chaining, not `&&`.
- **Agent platforms:** OpenCode (primary), Antigravity (secondary), VS Code Copilot (occasional).
- **File operations:** Prefer dedicated tools (Read, Write, Edit, Grep, Glob) over shell commands.
- **Memory MCP** available for persistent cross-session knowledge graph.

## Domain interests

- Quantum computing, quantum materials, simulated annealing
- AI agents, multi-agent systems, agentic workflows
- Research at the intersection of computation and materials
- Career: PhD planning, research positions
