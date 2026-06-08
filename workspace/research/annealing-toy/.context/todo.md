# todo.md

Active task list. Replace items as they complete. Move deferred items to `backlog.md`.
Each item has an `owner` field. Only the owner (or a session that has explicitly released the claim) may mark the item done.

## Claim protocol (CAS)

Before writing `owner: <your-session-id>` to an item:

1. Re-read the file.
2. Verify the item's `owner` is still `null` (or matches your session ID).
3. If changed, abort the claim, pick a different item, and append a note to `brain_dump.md`.

This is the compare-and-swap (CAS) pattern. It prevents two agents from claiming the same item concurrently.

## Format

```
- [ ] [Task description] | owner: <session-id or null> | started: YYYY-MM-DD | #priority #context
- [x] [Completed task] | owner: null | completed: YYYY-MM-DD
```

## Active

- [ ] [Task description] | owner: null | #priority #context
  - Notes: [optional sub-bullets]

## In Progress

- [ ] [Task currently being worked on] | owner: sess-20260607-abc123 | started: 2026-06-07
  - Notes: [progress notes]

## Blocked

- [ ] [Blocked task] | owner: null | Blocked by: [reason]

## Done (recent, last 5)

- [x] [Completed task] | owner: null | completed: 2026-06-07
