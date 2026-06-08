# verify

Workspace-agnostic verification skill.

This skill is designed as a last line of defense: it verifies claims by evidence rather than by memory, intent, or plausible-looking output. It applies to local repositories, generated artifacts, documents, code changes, current web facts, connector resources, remote systems, calculations, and user-provided logs/screenshots.

## Install shape

Place the directory as a skill folder:

```text
verify/
  SKILL.md
  modules/
  adapters/
  templates/
  tools/
  schemas/
  examples/
```

The root `SKILL.md` is self-contained enough for normal use. Load module/adapters only when relevant.

## Design changes from the old version

- Removed mandatory dependency on any named workspace root.
- Removed mandatory dependency on any specific registry, decision-record path, memory MCP, or agent framework.
- Replaced one rigid evidence schema with typed evidence records for files, commands, artifacts, web, connectors, calculations, screenshots, and user-supplied logs.
- Replaced “always stop if shell unavailable” with channel-aware verification. Shell is required only when the claim needs shell evidence.
- Split high-stakes checks into a multi-pass module.
- Added negative/contradiction checks as a first-class requirement.
- Added optional adapters for local workspace, git, code, documents, artifacts, remote systems, conversation/user input, math/logic, and coordination output.

## Recommended use

1. Extract atomic claims.
2. Select strictness: fast path, standard, or multi-pass.
3. Capture evidence with reproducible pointers.
4. Search for contradictions.
5. Give a scoped verdict.

## Tooling

`tools/evidence_capture.py` can run local commands and emit JSON evidence with stdout/stderr hashes.

Example:

```sh
python verify/tools/evidence_capture.py --claim-id C1 --evidence-id E1 --cwd . -- git status --short --branch
```
