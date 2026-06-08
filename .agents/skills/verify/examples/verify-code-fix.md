# Example — Verify a Code Fix

## Claim ledger

| ID | Claim | Expected Evidence |
|---|---|---|
| C1 | The reported bug is fixed. | Failing input now returns expected output. |
| C2 | Regression coverage was added. | Test exists and fails if fix is removed/mutated. |
| C3 | Relevant test suite passes. | Targeted and relevant broader tests pass. |

## Checks

- Inspect changed implementation lines.
- Run the failing input.
- Run the targeted test.
- Run relevant suite/build.
- Search for duplicate implementations.

## Negative check

If feasible, temporarily mutate/remove the fix and confirm the regression test fails. Restore immediately afterward.
