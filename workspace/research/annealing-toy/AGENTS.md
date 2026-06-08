# AGENTS.md (Project-Scoped)

This file overrides the root `AGENTS.md` for files inside this project.
Read this before doing any work in this project.

**Target scale:** 2-3 parallel agents per project. If you need 5+, use a database-backed coordinator instead.

## Hard Rules

- Default operating scope is the project root, not the workspace.
- Do not modify files outside this project without explicit approval.
- Always claim your session in `.context/.sessions/<your-session-id>.json` before reading or writing.

## Context Files

This project uses a `.context/` subfolder for operational context. Read order at session start:

1. `.context/project.md` - what this project is
2. `.context/todo.md` - what is active now (check `owner` field, do not pick up items owned by another active session)
3. `.context/brain_dump.md` - latest 200 lines of recent reasoning
4. `.context/.sessions/` - active session manifests (other agents working in parallel)

Other files in `.context/`:

- `.context/backlog.md` - deferred work
- `.context/ideas_tracker.md` - open ideas with status
- `.context/changelog.md` - completed work log
- `.context/failure_log.md` - failure ledger
- `.context/promotion_queue.md` - candidates for global context promotion

## Session Coordination (Designator Protocol)

Parallel agents coordinate via designator files, not file-level locks.

### Generating a unique session ID

`short-hash` must be unique across concurrent sessions. The default algorithm:

```
hash = SHA256( hostname + ":" + process_id + ":" + unix_epoch_seconds )[0:6]
session_id = "sess-" + YYYYMMDD + "-" + hash
```

Example: `sess-20260607-3f2a1b`

The combination of hostname, process ID, and epoch second makes collisions effectively impossible for 2-3 concurrent agents on a single host.

### On session start

1. Generate your session ID using the formula above.
2. Read `.context/.sessions/` to see who is active.
3. Write your manifest to `.context/.sessions/<your-session-id>.json.tmp` first.
4. Atomically rename `.json.tmp` to `.json` to avoid partial-write corruption.
5. Populate the manifest with:
   - `session_id`
   - `started_at` (ISO 8601)
   - `intent` (one-paragraph description of what you plan to do)
   - `claimed_items` (empty array initially)
   - `last_heartbeat` (ISO 8601, same as `started_at`)

The `.tmp` + rename pattern is a crash-safety primitive. If the agent dies mid-write, no manifest exists and the next agent can proceed cleanly.

### While working

1. **Heartbeat on action:** update `last_heartbeat` on every file read or write, not on a timer. The frequency is naturally bounded by the agent's pace. This avoids the long-running-op heartbeat-staleness problem.
2. **Update `claimed_items`** when you pick up a `todo.md` item or take ownership of an `ideas_tracker.md` entry.
3. **Claim with compare-and-swap (CAS):** before writing `owner: <your-id>` to a `todo.md` item, re-read the file and verify the item's `owner` is still `null`. If it has changed, abort the claim, pick a different item, and append a note to `brain_dump.md` explaining the failed claim.

### Append-only file write safety

When appending to `brain_dump.md`, `changelog.md`, or `failure_log.md`:

1. Read the current file.
2. Compute a SHA256 checksum of the read content.
3. Append your new content.
4. Read the new content and verify the original content (by checksum) is a prefix.
5. If not, another writer raced. Re-read, re-append, retry up to 3 times. If still failing, append a note to `failure_log.md` and HALT.

### On session end

1. Release all claimed items in `todo.md` and `ideas_tracker.md` (set `owner: null`). Use CAS: re-read before each write.
2. Move your session manifest to `.context/.sessions/.archive/<session-id>.json`.

### Conflict resolution

- **Item claim conflict:** older `started_at` wins. Newer session picks a different item or waits.
- **Append-only collision:** both entries are kept. Date headers prevent collision, but use the checksum protocol above to avoid lost writes.
- **Mutable file race:** newer writer wins. Loser re-reads and re-applies its change. This is rare in 2-3 agent setups.

### Stale session detection

A session is stale if `last_heartbeat` is more than 30 minutes old. The next agent to start may move stale manifests to `.context/.sessions/.stale/` and release their claimed items (using CAS).

## Reconciliation at Free Stages

A "free stage" is any moment when no urgent work is pending: end of task, end of day, before handoff, between major milestones.

At a free stage, reconcile:

1. **Acquire the reconciliation slot:** write a `reconciling: true` flag in your session manifest. If another session's manifest has `reconciling: true` and its `last_heartbeat` is fresher than 10 minutes, wait or do non-conflicting work.
2. **Review active sessions.** Read `.context/.sessions/` and identify sessions with `last_heartbeat` older than 30 minutes. Move them to `.sessions/.stale/` and release their claimed items using CAS.
3. **Merge brain dumps.** If multiple sessions appended on the same day, scan for redundancy and merge related entries into a single coherent entry. Do not delete; supersede.
4. **Promote validated ideas.** Any `ideas_tracker.md` item with status `validated` is a candidate for global context. Move it to `promotion_queue.md` with `pending` status.
5. **Archive old entries.** If `brain_dump.md` exceeds 2000 lines, move entries older than 90 days to `.context/.archive/YYYY-MM/brain_dump.md`. Same for `changelog.md` and `failure_log.md` per the rotation policy.
6. **Close your own session.** Release claimed items (CAS), move your manifest to `.sessions/.archive/`, clear the `reconciling` flag.

Reconciliation is a write operation. If you crash mid-reconciliation, the next reconciler should detect partial state by checking for incomplete archives or orphaned claims.

## Promotion Queue

When a project-level idea, pattern, or learning should be promoted to global context, add it to `.context/promotion_queue.md` with:

- The source file and entry
- The target global file path
- The reasoning for promotion

A sync agent will flush the queue on demand. Do not promote directly; the queue is the relay.

## See Also

- Root `AGENTS.md` for global rules
- `.agents/user/identity.md` for system identity
- `.agents/user/preferences.md` for user style preferences
