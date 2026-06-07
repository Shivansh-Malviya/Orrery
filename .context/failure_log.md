# failure_log.md

Per-project failure ledger. Append-only, latest first.
Track what broke, why, and what was done about it. Do not delete entries; mark resolved.

## Status

- `open` - failure observed, not yet addressed
- `investigating` - root cause being determined
- `mitigated` - workaround in place, root cause unresolved
- `resolved` - root cause fixed
- `wontfix` - deliberately not addressed (with reason)

## Format

```
## YYYY-MM-DD | STATUS | severity

- **What:** [What broke]
- **Where:** [File, function, or component]
- **When:** [When it was observed]
- **Impact:** [Who/what was affected]
- **Root cause:** [Why it broke, if known]
- **Action taken:** [What was done]
- **Prevention:** [What will stop it from recurring]
- **Related:** [Links to brain_dump.md, changelog.md, or external refs]
```

## Active Failures

[None yet.]

## Resolved

[None yet.]
