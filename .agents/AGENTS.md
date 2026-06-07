---
module: shared-agents
last_updated: 2026-06-07
---

# .agents

Cross-platform shared resources usable by any agent platform.
Platform-agnostic; consumed by VS Code Copilot, Antigravity, OpenCode, Cursor.

## Structure
- rules/      - Cross-platform behavioral rules
- skills/     - Shared skill definitions
- workflows/  - Shared multi-step procedures

Platform-specific adapters (VS Code, GitHub, etc.) live in their own hidden dirs
(`.github/`, etc.), NOT under `.agents/`.