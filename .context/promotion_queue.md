# promotion_queue.md

Candidates for promotion from this project to global context.
The sync agent reads this file and flushes entries to `/system/context/`.

## Format

```
## YYYY-MM-DD | source -> target

- **Source:** [.context/<file>.md, entry or section]
- **Target:** [/system/context/<file>.md]
- **Reason:** [Why this should be global]
- **Status:** [pending | approved | rejected | flushed]
```

## Pending

## Approved

## Rejected

## Flushed

[None yet.]
