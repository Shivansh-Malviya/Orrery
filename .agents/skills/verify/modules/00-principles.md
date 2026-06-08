# 00 — Principles and Failure Modes

## Core invariant

Verification is not confidence-building prose. It is an evidence accounting procedure. The output must make it possible to answer:

1. What claim was checked?
2. What evidence was inspected?
3. What evidence would contradict it?
4. What remains unchecked?
5. What verdict follows from the evidence?

## Last-line-of-defense posture

Assume the previous worker may have:

- changed the wrong file;
- updated only visible text but not underlying logic;
- run the wrong test command;
- relied on stale memory;
- missed generated/build artifacts;
- verified presence instead of behavior;
- checked one path but shipped another;
- overgeneralized from a sample;
- used a workspace-specific rule outside its workspace;
- declared success after a command timed out, failed, or was not run.

## Anti-patterns

Do not accept any of the following as sufficient by itself:

- “I remember doing it.”
- “The file exists.”
- “The output looks plausible.”
- “The diff is small.”
- “The test suite usually covers this.”
- “The user likely meant X.”
- “No error was shown.”
- “A previous agent said it was complete.”

## Evidence hierarchy

Prefer higher-grade evidence when available:

1. Reproducible command output with exact command, cwd, exit code, timestamp, and hashes.
2. Source file excerpt with path and line range.
3. Git diff/status/log for repo-state claims.
4. Test/build/lint/typecheck output for code-behavior claims.
5. Artifact inspection for generated files.
6. Authenticated connector/API evidence for remote resources.
7. Authoritative web citation with retrieval date for external claims.
8. User-provided logs or screenshots, clearly labeled as user-supplied.
9. Logical derivation for mathematical claims.

Lower-grade evidence can support a verdict only when the claim does not require higher-grade evidence.
