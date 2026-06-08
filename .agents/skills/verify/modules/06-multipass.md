# 06 — Multi-Pass Verification

Use this for high-risk, critical, broad, destructive, security-sensitive, release/deploy, public-facing, or user-critical cases.

## Pass A — Baseline and scope lock

- Capture current state before checking or changing anything.
- Record git status/diff/log if in a repo.
- Record artifact timestamps/hashes if verifying generated files.
- Define the exact claim ledger.
- State what would count as disproof.

## Pass B — Direct evidence

For each claim:

- run the most direct check available;
- inspect the exact file/resource/artifact;
- capture command/tool output;
- verify all claimed destinations or outputs, not only source inputs.

## Pass C — Contradiction search

Look for evidence against the claim:

- old identifiers, stale paths, duplicate files;
- alternate branches/build outputs/deploy targets;
- failed/ignored/skipped tests;
- hidden generated artifacts;
- cached or stale UI;
- conflicting docs;
- security-sensitive leftovers;
- inconsistent external sources.

## Pass D — Independence check

Ask:

1. Did I rely on the same source twice and count it as independent evidence?
2. Did I verify behavior, not just structure?
3. Did I check the shipped/rendered/generated form, not just the source form?
4. Did I check the negative case that would expose a false pass?
5. Would another reviewer reproduce my evidence from the report?

## Pass E — Residual-risk review

Report:

- checks not run;
- channels unavailable;
- assumptions;
- stale evidence risk;
- sample boundary;
- possible false negatives/false positives;
- exact next checks needed for a stronger verdict.
