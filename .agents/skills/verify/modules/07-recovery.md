# 07 — Recovery When Verification Fails

When verification fails, avoid vague apologies and avoid re-declaring completion.

## Recovery sequence

1. Name the failed claim.
2. Show the contradicting evidence.
3. Explain what verification step caught it.
4. Identify the minimal corrective action.
5. Apply the correction only if authorized and safe.
6. Re-run the exact failed verification plus relevant regression checks.
7. Add or update a guardrail when the failure pattern is repeatable.

## Failure pattern log

If the workspace has a failure log, use it. If not, suggest or create one only when useful.

Recommended entry shape:

```markdown
## YYYY-MM-DD — <failure title>

- Claim that failed:
- Evidence that contradicted it:
- Root cause:
- Guardrail added:
- Verification command/check that must catch it next time:
```

Do not assume a fixed failure-log path.
