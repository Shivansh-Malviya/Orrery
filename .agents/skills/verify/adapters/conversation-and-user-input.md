# Adapter — Conversation and User-Provided Input

Use when verifying claims made in the current conversation, earlier assistant output, pasted text, screenshots, transcripts, logs, uploaded files, or ambiguous user-supplied context.

## Claim sources

- Current user request.
- Previous assistant answer or generated artifact.
- Pasted logs, screenshots, tables, or transcripts.
- Uploaded files and their visible/extracted content.
- User-stated constraints, preferences, or facts relevant to the task.

## Checks

- Extract atomic claims from the relevant message or artifact before checking.
- Separate what the user explicitly provided from what was inferred.
- Prefer uploaded-file citations, exact excerpts, screenshot regions, or tool-returned records over memory.
- When the claim depends on earlier context not visible or accessible, mark that portion `AMBIGUOUS` and request or identify the missing source.
- For correction requests, verify both the original failure and the patched state.

## Cautions

- A user screenshot proves what was visible at capture time, not necessarily current remote state.
- Pasted logs may be truncated, edited, stale, or from the wrong environment.
- Conversation memory is not evidence unless the relevant message or saved context can be cited or inspected.
- Do not convert a likely interpretation of the user’s intent into a verified claim.
