# 01 — Scope, Claim Extraction, and Risk

## Claim ledger

Before checking, write down the claims to be verified.

| Field | Meaning |
|---|---|
| `claim_id` | Stable short id: C1, C2, C3. |
| `claim` | One atomic statement. |
| `source` | User request, previous answer, file, commit, artifact, UI, etc. |
| `expected_evidence` | What would prove or disprove it. |
| `risk` | low, normal, high, critical. |
| `status` | UNVERIFIED, PASS, FAIL, PARTIAL, AMBIGUOUS, NOT_RUN. |

## Splitting rules

Split claims when they involve different evidence channels.

Examples:

- “Fixed the login bug and added tests” → behavior check, regression test check, changed-file check.
- “Updated all docs” → inventory of docs, reference search, excerpt validation.
- “The deployment is live” → build/deploy status, public endpoint behavior, version/commit alignment.
- “This statement is true” → source quality, source recency, contradiction search, domain caveats.

## Risk classification

### Low

Small local checks with reversible consequences. Example: one file exists, one line changed, one typo fixed.

### Normal

Most code, doc, repo, artifact, and factual verification.

### High

Use multi-pass when any apply:

- destructive operation: delete, move, rename, overwrite, restore;
- broad change: more than five files, generated artifacts, migrations, dependency changes;
- release/deploy/commit/handoff/publication;
- external claims with user-facing consequences;
- security, privacy, access control, credentials, cryptography, payments, legal, medical, safety;
- the user explicitly says this is important, final, last line of defense, critical, production, or irreversible.

### Critical

Use multi-pass and clearly report residual risk. Includes secrets exposure, production incidents, data loss, compliance, financial/legal/medical/safety decisions, and irreversible publication.

## Scope boundary

Every report must state:

- included claims;
- excluded claims;
- tools/channels used;
- tools/channels unavailable;
- whether the check was exhaustive or sampled.
