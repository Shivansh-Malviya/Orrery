---
title: BROS_SYSTEM -> Orrery
last_updated: 2026-06-07
type: system-migration
status: in-progress
---

## Summary
- From: F:\BROS_SYSTEM\
- To: F:\Orrery\
- Started: 2026-06-07

## What was migrated
- Directory structure (new skeleton based on a new target spec)
- File conventions (.manifest.md for system-tracking files, uniform hidden-dir pattern)

## What was not migrated
- ACOS (Application Campaign OS) - correctly configured in F:, schema was wrong; left in place
- Old workspace content (academic/, career/, ina/, personal/) - left as legacy stubs under workspace/inbox/

## Open items
- Populate root-level dirs (policy, system, hooks, etc.) with proper content
- Migrate BROS enforcer scripts (or rewrite for Orrery)
- Migrate BROS hooks
- Migrate policy files