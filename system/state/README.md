# system/state/ — Dynamic Runtime State

Ephemeral state that changes during system operation.

## Contents

- `active-sessions/` — Currently active session manifests (mirrored from session designator protocol)
- `completed/` — Completed operation records
- `rejected/` — Rejected operation records

This directory is reset on system restart (not committed to git).
