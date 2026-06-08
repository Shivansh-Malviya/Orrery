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

## Resolved (recent, last 10)

- 2026-06-07 | resolved | low
  - **What:** `.context/` folder not visible in Windows Explorer by default
  - **Where:** Project root
  - **When:** 2026-06-07
  - **Impact:** New collaborators may miss the folder
  - **Root cause:** Hidden folder convention
  - **Action taken:** Documented in `.context/README.md`; added entry to project's root `AGENTS.md`
  - **Prevention:** Include `.context/` mention in onboarding docs
  - **Related:** See DA report `F:\Bros\opencode\reports\DA_context_corpus_2026-06-07.md`
