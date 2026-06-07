---
name: "Output Path Policy"
last_updated: 2026-06-07
type: policy
status: active
---

# Output Path Policy (Orrery)

This is the active output-path policy for the Orrery workspace. It supersedes
the pre-Orrery BROS_SYSTEM version of OUTPUT_PATH_POLICY (migrated to
`archive/planning-chain/governance/OUTPUT_PATH_POLICY.md` for historical
reference; do not use that copy as active policy).

## Workspace Root

- Active workspace root: `F:\Orrery\`
- The runtime agent(s) operate within this workspace.

## Path Safety Rules

### Read

- Any path is allowed for read-only queries.
- Exception: paths that contain secrets (API keys, tokens, credentials, private
  keys, password files) are forbidden for any access.

### Write

- Writes are allowed to any path.
- Exception: paths containing secrets are forbidden for write.
- Recommended practice: respect user-owned data; avoid overwriting files
  without explicit authorization.
- Archive-first: when restructuring or removing files, prefer moving them to
  `.archive/` over deletion.

## Source-of-Truth Cross-References

The following paths may be referenced from Orrery docs. They are read-only
cross-references, not write targets:

- `F:\BUTLER_ROOT\` — historical source of truth for the migration. Read-only access is fine.
- `F:\BROS_SYSTEM\` — historical BROS tree, pre-Orrery. Read-only access is fine.
- `F:\Bros\opencode\templates\context\README.md` — canonical design source for the designator protocol. Read-only access is fine.

## Envelope Rules (NOT for general tasks)

A strict response envelope (final status line + strict JSON completion block)
applies **only** to specific contract-template tasks where the contract is
provided to the agent in the format established by an established template
contract. For general tasks, verbose prose responses are allowed and
expected.

## Notes

- This policy intentionally removes the BROS_SYSTEM-era "forbidden write root:
  F:\BUTLER_ROOT\" rule, which was specific to the BROS runtime sandbox and does
  not apply to a personal workspace.
- Agents operating in Orrery should follow the path-safety rules above.
