# promotion_queue.md

Candidates for promotion from this project to global context.
The sync agent reads this file and flushes entries to `.agents/user/`.

## Format

`
## YYYY-MM-DD | source -> target

- **Source:** [.context/<file>.md, entry or section]
- **Target:** [.agents/user/<file>.md]
- **Reason:** [Why this should be global]
- **Status:** [pending | approved | rejected | flushed]
`

## Pending

## Approved

## Rejected

## Flushed

[None yet.]
