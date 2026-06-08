# system/admission/ — Operations Staging

Staging area for operations requiring review before execution into the Orrery runtime.
Analogous to a PR staging area for system-level changes.

## Protocol

1. Proposed system operation is documented here
2. Reviewed against policy at `policy/`
3. If approved, executed and moved to `system/state/completed/`
4. If rejected, moved to `system/state/rejected/`
