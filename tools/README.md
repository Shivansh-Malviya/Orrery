# tools

Tools are capabilities, not authorities. Tool internals stay native.
Read `tools/registry.md` before using a named tool.

## Registry

See `tools/registry.md` for the authoritative tool routing table.

## Structure

- `adapters/` — Tool adapters
- `mcp/` — MCP server configurations
- `scripts/` — Utility scripts (incl. `validate_structure.py`)
- `shims/` — Tool shims
- `templates/` — Tool templates

## Key tools

| Tool | Purpose | Workspace |
|---|---|---|
| HenryDaum Second Brain | Runtime/indexer candidate | — |
| Hermes | Messaging/interface layer | — |
| ScienceClaw | Research specialist | — |
| Lattice | Holistic personal knowledge hub | `workspace/lattice/` |
| ArgOS | Application/campaign OS | `workspace/argos/` |
| WorkBrain | Restricted work-domain second brain | `workspace/work/` |
| OpenCode | Coding harness | — |
| Antigravity | Agentic development harness | — |
| VS Code/Copilot | Editor/completion assistant | — |

## Validation

Run `python tools/scripts/validate_structure.py .` after structural changes.
