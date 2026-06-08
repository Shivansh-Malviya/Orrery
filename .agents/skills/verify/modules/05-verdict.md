# 05 — Verdict Semantics

## Verdicts

- `PASS`: Evidence directly supports the claim; contradiction search found no material conflict; scope is adequate.
- `FAIL`: Evidence contradicts the claim or proves the work was not done.
- `PARTIAL`: Some subclaims pass; others fail, remain unchecked, or are out of scope.
- `AMBIGUOUS`: Evidence is insufficient, stale, unavailable, sampled when exhaustive evidence is needed, or supports multiple interpretations.
- `NOT_RUN`: Required check was not executed.

## Verdict discipline

- Do not convert `AMBIGUOUS` into `PASS` because the likely answer seems favorable.
- Do not mark broad claims as `PASS` based on one narrow check.
- If a check is skipped, record it as skipped with reason.
- If a test passes with warnings relevant to the claim, do not hide them.
- If the result depends on an assumption, include the assumption in residual risk.

## Confidence labels

Optional confidence labels may be added, but they cannot override the verdict.

- High confidence: direct, reproducible, current evidence.
- Medium confidence: direct evidence but limited coverage or non-exhaustive search.
- Low confidence: indirect evidence, user-supplied artifact only, or missing access to decisive channel.
