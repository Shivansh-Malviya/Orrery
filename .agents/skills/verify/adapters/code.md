# Adapter — Code and Tests

Use when verifying a bug fix, implementation, refactor, build, dependency change, or runtime behavior.

## Minimum standard

1. Identify the specific behavior claimed.
2. Locate implementation files changed or relevant.
3. Reproduce or inspect the failing case where possible.
4. Run targeted tests.
5. Run broader tests/build/lint/typecheck when scope justifies it.
6. Search for duplicate/stale implementations.

## Test evidence quality

High-grade evidence:

- targeted regression test fails before/fails with mutation and passes after;
- command output shows test file/name;
- implementation line excerpt matches intended behavior;
- broader suite passes or known failures are isolated.

Weak evidence:

- “all tests passed” without command/output;
- generated coverage with no assertion inspection;
- a snapshot update without semantic check;
- lint passing for a functional bug.

## Mutation/negative check

When feasible, ask: if the fix were removed, would the test fail? If not, the test is not sufficient evidence.
