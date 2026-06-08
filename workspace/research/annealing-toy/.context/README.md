# Project-Level Context Template

**Version:** 2026-06-07
**Location:** `.context/` at project root
**Discovery:** Referenced from project `AGENTS.md`
**Target scale:** 2-3 parallel agents per project. Larger deployments need a database-backed coordinator.

---

## Realistic scale

This template is right-sized for 1 human + 2-3 parallel agents. The designator protocol, CAS claims, and reconciliation logic are designed for that scale. If you anticipate 5+ agents, a SQLite-based coordinator is a better fit; see "Scaling beyond 3 agents" below.

---

## Why `.context/` is hidden

Antigravity reads `.agent/rules/*.md` natively. OpenCode walks up from the working file to find ancestor `AGENTS.md` files. Both harnesses treat dot-prefixed directories as agent-internal surfaces. A hidden `.context/` keeps operational logs out of casual browsing without requiring harness-specific config.

If a tool ignores hidden directories, document the path in `AGENTS.md` so the agent can read it explicitly. Windows users should enable "Show hidden files" or use a CLI that includes `-Force` (PowerShell) / `-a` (Unix).

---

## Files in this template

| File | Purpose | Written by | Read by |
|------|---------|------------|---------|
| `AGENTS.md` | Project-specific agent contract | human, agent | agent at session start |
| `project.md` | Project description: problem, goal, scope, status | human | agent, human |
| `brain_dump.md` | WHY-only thought stream, append-only, latest first | agent, human | agent |
| `backlog.md` | Parking lot for deferred work | agent, human | agent |
| `todo.md` | Active task list with `owner` field for work-claim | agent, human | agent |
| `ideas_tracker.md` | Open ideas with status lifecycle | agent, human | agent |
| `changelog.md` | Completed work log, latest first | agent (auto), human | human, agent |
| `failure_log.md` | Failure ledger with status, root cause, prevention | agent, human | agent, human |
| `promotion_queue.md` | Candidates for global context promotion | agent | sync agent |
| `.sessions/` | Per-session manifests for parallel agent coordination | each agent | all agents |
| `.sessions/.archive/` | Closed session manifests | each agent | reconciliation |
| `.sessions/.stale/` | Stale manifests pending release | reconciliation agent | reconciliation |
| `README.md` | This file | human | human, agent |

---

## Parallel Agent Coordination (Designator Protocol)

File-level locks were considered and rejected because they create a single point of contention. Instead, parallel agents coordinate via **session manifests** in `.context/.sessions/`.

### Generating a unique session ID

`short-hash` must be unique across concurrent sessions. The default algorithm:

```
hash = SHA256( hostname + ":" + process_id + ":" + unix_epoch_seconds )[0:6]
session_id = "sess-" + YYYYMMDD + "-" + hash
```

Example: `sess-20260607-3f2a1b`

The combination of hostname, process ID, and epoch second makes collisions effectively impossible for 2-3 concurrent agents on a single host. If you run multi-host, use a UUIDv4 library or include the hostname in the hash (already done).

### On session start

1. Generate your session ID using the formula above.
2. Read `.context/.sessions/` to see who is active.
3. Write your manifest to `.context/.sessions/<your-session-id>.json.tmp` first.
4. Atomically rename `.json.tmp` to `.json`. The rename is atomic on the same filesystem.
5. Populate the manifest with:
   - `session_id`
   - `started_at` (ISO 8601)
   - `intent` (one-paragraph description of what you plan to do)
   - `claimed_items` (empty array initially)
   - `last_heartbeat` (ISO 8601, same as `started_at`)

The `.tmp` + atomic-rename pattern is a crash-safety primitive. If the agent dies mid-write, no manifest exists and the next agent can proceed cleanly.

### While working

1. **Heartbeat on action:** update `last_heartbeat` on every file read or write, not on a timer. The frequency is naturally bounded by the agent's pace. This avoids the long-running-op heartbeat-staleness problem.
2. **Update `claimed_items`** when you pick up a `todo.md` item or take ownership of an `ideas_tracker.md` entry.
3. **Claim with compare-and-swap (CAS):** before writing `owner: <your-id>` to a `todo.md` item, re-read the file and verify the item's `owner` is still `null`. If it has changed, abort the claim, pick a different item, and append a note to `brain_dump.md` explaining the failed claim.
4. **Append-only file write safety:** when appending to `brain_dump.md`, `changelog.md`, or `failure_log.md`:
   - Read the current file.
   - Compute a SHA256 checksum of the read content.
   - Append your new content.
   - Read the new content and verify the original checksum is a prefix.
   - If not, another writer raced. Re-read, re-append, retry up to 3 times. If still failing, append a note to `failure_log.md` and HALT.

### On session end

1. Release all claimed items in `todo.md` and `ideas_tracker.md` (set `owner: null`). Use CAS: re-read before each write.
2. Move your session manifest to `.context/.sessions/.archive/<session-id>.json`.

### Conflict resolution

- **Item claim conflict:** Older `started_at` wins. Newer session picks a different item or waits.
- **Append-only collision:** Both entries are kept if the checksum protocol succeeds. If checksums fail, retry up to 3 times; if still failing, log to `failure_log.md` and HALT.
- **Mutable file race:** Newer writer wins. Loser re-reads and re-applies its change. Rare at 2-3 agent scale.
- **Stale session:** A session is stale if `last_heartbeat` is more than 30 minutes old. The next agent may move it to `.sessions/.stale/` and release its claimed items using CAS.

### Why designators and not locks

- Locks create a single point of contention. Two agents waiting on the same lock cannot do anything else.
- Locks require a central registry that may be unavailable. The designator protocol only requires the filesystem.
- Locks are binary. Designators carry intent, which is useful for coordination.
- Locks do not survive crashes well. A designator with a stale heartbeat is detected and cleaned up by the next agent.
- Locks do not handle "newer writer wins" gracefully. Designators with CAS handle the common case.

---

## Reconciliation at Free Stages

A "free stage" is any moment when no urgent work is pending: end of task, end of day, before handoff, between major milestones.

At a free stage, reconcile:

1. **Acquire the reconciliation slot:** write a `reconciling: true` flag in your session manifest. If another session's manifest has `reconciling: true` and its `last_heartbeat` is fresher than 10 minutes, wait or do non-conflicting work.
2. **Review active sessions.** Read `.context/.sessions/` and identify sessions with `last_heartbeat` older than 30 minutes. Move them to `.sessions/.stale/` and release their claimed items using CAS.
3. **Merge brain dumps.** If multiple sessions appended on the same day, scan for redundancy and merge related entries into a single coherent entry. Do not delete; supersede.
4. **Promote validated ideas.** Any `ideas_tracker.md` item with status `validated` is a candidate for global context. Move it to `promotion_queue.md` with `pending` status.
5. **Archive old entries.** If `brain_dump.md` exceeds 2000 lines, move entries older than 90 days to `.context/.archive/YYYY-MM/brain_dump.md`. Same for `changelog.md` and `failure_log.md` per the rotation policy below.
6. **Close your own session.** Release claimed items (CAS), move your manifest to `.sessions/.archive/`, clear the `reconciling` flag.

Reconciliation is a write operation. If you crash mid-reconciliation, the next reconciler should detect partial state by checking for incomplete archives or orphaned claims.

---

## Rotation Policy

On-demand. No automatic rotation. Soft limits:

- `brain_dump.md` exceeds 2000 lines: move entries older than 90 days to `.context/.archive/YYYY-MM/brain_dump.md`.
- `changelog.md` exceeds 1000 entries: move entries older than 180 days to `.context/.archive/YYYY-MM/changelog.md`.
- `failure_log.md` exceeds 500 entries: move resolved entries older than 365 days to `.context/.archive/YYYY-MM/failure_log.md`.

Archive paths are gitignored by default (see "Tooling" below).

---

## Global Context Relay

Project-level context is relayed to global context via a sync agent that reads `promotion_queue.md` and writes to `.agents/user/`.

### The sync agent workflow

1. Scan all project `.context/promotion_queue.md` files.
2. For each `pending` entry:
   - Read the source file and entry to verify the content.
   - If the entry is already covered in the target global file, mark it `rejected` with reason `duplicate`.
   - Otherwise, append the entry to the target global file with a backlink to the project source.
   - Mark the queue entry `flushed` with the sync agent's session ID and the target file path.
3. Update `.agents/user/preferences.md` if a project's last-updated timestamp changed.

### The global index

The global context at `.agents/user/` tracks project state with:

- Project path
- One-line summary (from `project.md` first paragraph)
- Last-updated timestamp
- Number of open promotion queue entries

The sync agent updates this file as part of its workflow. Global context agents read this file first to see what is happening across all projects.

### Manual trigger

The user invokes the sync agent explicitly. There is no automatic scheduling. The agent is a single-purpose skill that runs on demand, not a background process.

### Why a sync agent and not direct writes

- Direct writes from project agents to global context require file locks across the workspace, which contradicts the designator protocol.
- A sync agent is a single point of audit. Every global write goes through one identity.
- A sync agent can deduplicate, validate, and reformat before writing to global.
- A sync agent can be triggered manually or scheduled, but the design is the same.

---

## Tooling: `.contextignore`

Place a `.contextignore` file at the project root (alongside `.context/`) to keep IDEs, linters, and static analyzers from scanning the folder. Recommended contents for common stacks:

```
# Python
.mypy_cache/
.pytest_cache/
.ruff_cache/

# Node
node_modules/
.next/
dist/

# Editors
.vscode/
.idea/
*.swp
```

---

## Cross-platform case sensitivity

`.context/` (Windows) and `/home/user/project/.context/` (Linux) are the same on Windows but different on case-sensitive filesystems. Scripts that reference the folder must use lowercase. The template uses lowercase for all file names.

---

## Discovery protocol for agents

1. Read project root `AGENTS.md` first. It will reference this folder.
2. Read `.context/AGENTS.md` for project-scoped rules.
3. Read `.context/project.md` for project description.
4. Read `.context/todo.md` for active work. Check `owner` field against active sessions.
5. Read `.context/.sessions/` to see who else is working in parallel.
6. Read the last 200 lines of `.context/brain_dump.md` for recent reasoning.

Other files are read on demand.

---

## Migration from older BROS context

The original BROS structure plan placed all context at `system/context/` (global). The current layout uses per-project `.context/` for project state and `.agents/user/` for global identity/preferences.

If you have existing project files in another location:

1. Identify the project they belong to.
2. Copy the relevant files to the project's `.context/` folder.
3. Add a redirect note at the top of the old file: `Moved to <project>/.context/<file>.md on YYYY-MM-DD.`
4. Update the project's root `AGENTS.md` to reference the new location.
5. Do not delete the old file until the new location has been verified by at least one session.

---

## DA findings addressed

The template addresses findings from `F:\Bros\opencode\reports\DA_context_corpus_2026-06-07.md` (initial design) and `F:\Bros\opencode\reports\DA_context_working_dynamics_2026-06-07.md` (working dynamics).

### Initial design DA

1. **Hidden folder invisibility** - documented in "Why `.context/` is hidden" and "Tooling".
2. **Lock ownership clarity** - replaced with designator protocol; no file-level locks.
3. **Permission drift** - "Cross-platform case sensitivity" addresses common failure modes.
4. **Naming collision** - lowercase naming enforced; `.contextignore` provided.
5. **Initial population** - every template file ships with example content.
6. **Promotion to global** - "Global Context Relay" specifies the sync agent workflow.
7. **Merge strategy for parallel writes** - designator protocol + reconciliation at free stages.
8. **Deletion safety** - "Migration from older BROS context" specifies verification.
9. **Stale BROS structure plan** - noted in migration section.

### Working dynamics DA (applied)

1. **Session ID collision** - SHA256 of `hostname:pid:epoch_second`, truncated to 6 hex. Effectively zero collisions at 2-3 agent scale.
2. **Manifest write crash** - `.json.tmp` + atomic rename. Partial writes are impossible.
3. **Heartbeat on long-running ops** - heartbeat-on-action instead of timer. Live sessions cannot be falsely marked stale.
4. **Claim race on same item** - CAS protocol: re-read before write, abort if owner changed.
5. **Append-only file race** - SHA256 prefix check on read content. Retry up to 3 times; log and HALT on persistent failure.
6. **Reconciliation is a write** - `reconciling: true` flag with 10-minute stale timeout. One agent at a time.

### Working dynamics DA (not applied, out of scope for 2-3 agents)

- Sync agent invocation lock and global index append-only log. Single-user, manually-triggered sync is acceptable at this scale.
- Multi-machine coordination. Template assumes single host.
- Automatic rotation. User-triggered is acceptable.
- Promotion queue validation. Sync agent (when built) will handle malformed entries by marking them `rejected`.

---

## Scaling beyond 3 agents

If your deployment grows past 3 concurrent agents per project:

1. **Replace `.sessions/` manifests with a SQLite database** at `.context/.state.db`. Tables: `sessions`, `claims`, `heartbeats`, `promotion_queue`. Single-writer, multi-reader.
2. **Replace CAS protocol with database transactions.** The file-based CAS is fragile under high contention; a database transaction is atomic.
3. **Add a coordinator process** that watches for stale sessions and orphaned claims. The opportunistic cleanup in this template is not sufficient at 5+ agents.
4. **Switch to event sourcing** for `brain_dump.md`, `changelog.md`, and `failure_log.md`. Append-only event log is the same shape as a database log.

Until you cross 3 agents, the file-based template is simpler to deploy, debug, and reason about.

---

## Known limitations

- **Mutable file races are rare but possible** at 2-3 agent scale. The convention is "newer writer wins, loser re-reads." If you see this happen, switch to CAS for that file.
- **Reconciliation flag is a convention** - not enforced. If two agents both write `reconciling: true` simultaneously, both will reconcile. The 10-minute stale timeout mitigates but does not prevent.
- **Sync agent is unwritten** - the promotion queue will accumulate `pending` entries until the sync agent is built. Plan to build it.
- **Brain dump merge ambiguity** - if two sessions append contradictory reasoning on the same day, the merged entry is ambiguous. A human must resolve during reconciliation.
- **Clock skew** - if two agents have clocks 2+ minutes apart, the older-`started_at`-wins rule can flip. The protocol assumes NTP-synchronized clocks within 1 minute.
- **No multi-machine coordination** - the designator protocol assumes a single host. Cross-host coordination requires a shared lock service or database.
