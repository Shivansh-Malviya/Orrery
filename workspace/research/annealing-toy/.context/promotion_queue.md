# promotion_queue.md

Candidates for promotion from this project to global context.
The sync agent reads this file and flushes entries to `.agents/user/`.

## Format

```
## YYYY-MM-DD | source -> target

- **Source:** [.context/<file>.md, entry or section]
- **Target:** [.agents/user/<file>.md]
- **Reason:** [Why this should be global]
- **Status:** [pending | approved | rejected | flushed]
```

## Pending

## Approved

## Rejected

## Flushed (recent, last 10)

- 2026-06-07 | flushed
  - **Source:** .context/failure_log.md, entry "Windows hidden folder"
  - **Target:** .agents/user/lessons_learned.md
  - **Reason:** Hidden-folder discoverability is a cross-project concern
  - **Flushed by:** sync-agent sess-20260607-abc123
  - **Backlink:** .agents/user/lessons_learned.md#2026-06-07-windows-hidden-folder
