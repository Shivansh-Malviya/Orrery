# Cross-Platform Harness Contract

All agents operating in the Orrery workspace must follow:

1. **AGENTS.md hierarchy** — Root policy > module contract > tool-native rules
2. **Commit attribution** — Prefix commits: `OC-`, `AG-`, `VSC-`, `U-`
3. **Non-destructive by default** — Read-only exploration before mutations
4. **Session manifests** — Claim before writing, release on finish
5. **Local before global** — Write to project `.context/` first; promote via queue

Supported platforms: OpenCode, Antigravity, VS Code Copilot, Cursor.
