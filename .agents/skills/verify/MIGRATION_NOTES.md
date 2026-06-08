# Migration Notes: Old `verify` → Modular Workspace-Agnostic `verify`

## Problems in the uploaded version

1. **Workspace coupling remains in metadata.** The front matter names canonical protocols, `system_registry.yaml`, ADR paths, failure-log paths, and specific sibling skills. That makes the skill non-portable.
2. **Runtime coupling remains in the body.** The workflow explicitly loads `BUTLER_ROOT` files and calls a named memory MCP, so it still assumes one agent/workspace ecosystem.
3. **Invalid mixed shell block.** The Step 1 code block mixes PowerShell and POSIX shell syntax in a way that is not executable as one script.
4. **Evidence schema is too rigid.** Requiring `line_range`, `exact_command`, `exit_code`, and a 40-character `commit_sha` for every evidence item fails for web, connector, screenshot, artifact, mathematical, and user-supplied evidence.
5. **Shell-unavailable behavior is overbroad.** Some verification can be done from uploaded files, screenshots, citations, connectors, or reasoning without shell execution. Stopping unconditionally loses useful verification coverage.
6. **Target matrix is Butler-specific.** Registry/ADR/health-check assumptions should be optional adapters, not core logic.
7. **Triad output is hardcoded.** Coordination-specific output belongs in an adapter, not the main skill.
8. **“Before declaring any task complete” is too blunt.** It causes over-invocation for trivial responses and conflicts with the fast-path idea. The rewrite uses “substantive work complete” and gives a fast path.
9. **Remote verification wording is unsafe.** The old version says to use explicit user-provided credentials for remote CI/API logs. The rewrite says to use authorized connectors or redacted artifacts, not raw credentials.
10. **No claim ledger.** The old flow checks context first but does not force atomic claim extraction before selecting evidence.
11. **No generalized evidence channels.** It does not cleanly cover rendered artifacts, images, PDFs, spreadsheets, external facts, connectors, UI, or pure derivations.
12. **No clear contradiction-search requirement in standard mode.** The rewrite makes negative checks mandatory for standard/multi-pass verification.

## What changed structurally

- `SKILL.md`: compact invariant workflow and invocation rules.
- `modules/`: reusable verification machinery.
- `adapters/`: context-specific procedures loaded only when relevant.
- `templates/`: reusable report and manual-command formats.
- `tools/`: optional evidence-capture helper.
- `schemas/`: machine-readable evidence schema.

## Porting rule

Do not delete workspace-specific checks forever. Move them into adapters if they are still useful. The core skill must remain portable.


## Second-pass fixes applied

- Narrowed trigger wording to avoid treating generic “check” language as a verification request unless an existing claim/completion is being validated.
- Fixed nested Markdown fencing in the manual-command template.
- Strengthened evidence schema with timestamp/hash patterns, command-specific required fields, and stable pointer support.
- Added adapters for conversation/user input and mathematics/logic.
- Hardened `evidence_capture.py` with shell-safe command rendering, OSError handling, optional raw-output omission, and output truncation while preserving full-stream hashes.
- Added raw-output safety guidance to avoid leaking secrets/private data in verification reports.
