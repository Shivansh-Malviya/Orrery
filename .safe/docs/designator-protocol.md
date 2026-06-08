# Designator Protocol — Lock-Free Parallel Agent Coordination

## Core mechanism

Session manifests in `.context/.sessions/<session-id>.json` replace file-level locks.

## Session ID generation

```
hash = SHA256( hostname + ":" + process_id + ":" + unix_epoch_seconds )[0:6]
session_id = "sess-" + YYYYMMDD + "-" + hash
```

## Claim protocol

1. Re-read `todo.md` before writing `owner: <id>` (CAS pattern)
2. If owner changed since last read, abort claim
3. Release claimed items on session end

## Stale detection

Session is stale if `last_heartbeat` > 30 minutes old.
Next session moves stale manifests to `.sessions/.stale/` and releases claims.

## Scale

Designed for 2-3 parallel agents per project. Beyond that, use a database-backed coordinator.

See `F:\Bros\opencode\templates\context\README.md` for full protocol detail.
