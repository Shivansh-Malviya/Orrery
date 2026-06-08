# 02 — Evidence Contract

## Evidence item schema

Use this shape conceptually even when reporting in prose:

```json
{
  "evidence_id": "E1",
  "claim_id": "C1",
  "type": "command | file_excerpt | diff | test | build | artifact | screenshot | connector | web_source | calculation | user_supplied | manual_step",
  "source": "path, URL, resource id, artifact path, command, or user message",
  "locator": "line range, page, selector, commit, timestamp, row/cell, screenshot region, or n/a",
  "method": "how the evidence was obtained",
  "captured_at_utc": "YYYY-MM-DDTHH:MM:SSZ",
  "result_summary": "short factual summary",
  "raw_output_sha256": "64-char SHA-256 hash where available, otherwise null",
  "stable_pointer": "citation/resource pointer/artifact id where a hash is not available, otherwise null",
  "limitations": "what this evidence does not prove"
}
```

## Command evidence extension

For local commands, include:

```json
{
  "cwd": "absolute or repository-relative working directory",
  "exact_command": "command as executed",
  "exit_code": 0,
  "stdout_sha256": "...",
  "stderr_sha256": "...",
  "duration_seconds": 1.23
}
```

## File excerpt evidence

For file-content claims, include:

- path;
- line range if line-oriented;
- page/section/cell if not line-oriented;
- exact relevant excerpt when short enough;
- hash of extracted content when possible.

## External/web evidence

For external claims:

- use authoritative or primary sources when possible;
- include retrieval timestamp;
- check publication/update date;
- check whether the source actually supports the claim;
- include contradiction search results for nontrivial claims.

## Visual evidence

For screenshots/images/UI:

- identify image/source;
- identify region or element inspected;
- distinguish visible appearance from underlying functionality;
- use runtime/rendered checks when the claim is functional.

## Mathematical/logical evidence

For derivations:

- state assumptions;
- verify dimensions/types/domains;
- check edge cases/counterexamples;
- independently recompute at least one nontrivial step where feasible;
- mark as `AMBIGUOUS` if a result depends on an unstated theorem, numerical approximation, or convention.

## Missing evidence

If evidence is unavailable, say exactly what is missing. Do not replace missing execution with intention, memory, or invented output.
