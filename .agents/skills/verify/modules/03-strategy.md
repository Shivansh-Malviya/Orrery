# 03 — Verification Strategy Matrix

Select checks based on the claim type.

| Claim type | Preferred checks | Common false positive |
|---|---|---|
| File exists/removed/moved | `stat`, directory listing, source/destination check, git status | Destination exists but source still present. |
| File content changed | line-range excerpt, diff, search for old/new text | Edited duplicate/stale copy. |
| Code behavior fixed | reproduce failing case, run targeted test, run relevant suite, inspect implementation | Tests pass but failing case not covered. |
| Regression test added | locate test, run it, force-fail/mutate if feasible | Test exists but does not assert bug. |
| Build/package works | clean install/build, inspect artifact output | Incremental cache hides failure. |
| Docs updated | search references, inspect all relevant docs, validate examples | One doc updated, others stale. |
| Generated artifact created | check file exists, open/inspect metadata/content, validate format | File exists but content stale/wrong. |
| Count/list claim | exhaustive search command, deduping rule, negative search | Sample mistaken for full inventory. |
| Commit/release/deploy | git status/log/diff, tag/version, CI/deploy logs, endpoint/version check | Local state differs from deployed state. |
| Remote/API/connector state | authenticated read via connector/API, timestamped response, permission scope | UI cache or stale screenshot. |
| External factual claim | primary source, current source, contradiction search | Citation tangentially related. |
| Security/secrets | secret scan, git history scope if relevant, access-control check | Working tree clean but history leaked. |
| Data migration | source count, target count, sampling, checksum, rollback state | Counts match but records corrupted. |
| Visual/UI change | screenshot/render, DOM/component inspection, browser/device variants | Static screenshot hides interaction bug. |
| Mathematical claim | derivation, assumptions, edge cases, independent computation | Algebra correct under unstated constraints only. |

## Negative checks

Every standard or multi-pass verification should include at least one negative check, such as:

- search for old text/path/API still present;
- run failing input from before;
- check source and destination after move;
- inspect alternate/generated/stale copies;
- check that a reported number is not from a sample;
- compare local vs committed vs deployed state;
- look for contradictory authoritative sources.
