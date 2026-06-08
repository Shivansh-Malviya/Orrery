# Work Restricted Context Policy

## Status

WorkBrain is deferred.

## Current scope

`workspace/work/` is a restricted work-domain shim, not a full ArgOS-style OS.

## Constraints

- Do not mirror ArgOS structure.
- Keep work-domain second-brain behavior lightweight:
  - local notes/maps/exports only
  - restricted by default
  - no raw work indexing by Henry/Hermes/second-brain unless explicitly approved
- Only explicit export/map surfaces may be used for cross-system sharing.
- Sensitive work material must not be promoted into root `second-brain/`.
