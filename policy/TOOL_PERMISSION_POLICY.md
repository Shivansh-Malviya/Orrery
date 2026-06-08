# Tool Permission Policy

## Principle

Tools are capabilities, not authorities.

## Rule

Before using a named tool, read `tools/registry.md`. The registry must define allowed/forbidden read/write surfaces for each tool.

## Default stance

- **HenryDaum second-brain**: candidate runtime/indexer, read-only unless explicitly approved.
- **Hermes**: messaging/interface gateway, not canonical memory.
- **ScienceClaw**: research specialist only.
- **Lattice MCP/API**: approved personal-knowledge context interface only.
- **ArgOS**: authoritative for application/campaign memory.
- **Work shim**: restricted; export/map access only.

## Constraint

No tool may write canonical records unless the registry explicitly permits it.
