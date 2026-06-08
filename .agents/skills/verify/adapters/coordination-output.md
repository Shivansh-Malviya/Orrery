# Adapter — Coordination / Mediator Output

Use only when the surrounding workflow requires a compact machine-readable verification block.

This adapter intentionally avoids naming any specific workspace or agent framework.

## Compact block

```markdown
### [VERIFICATION STATE]
**Objective Verified:** <objective or claim ids>
**Scope:** <included / excluded>
**Method:** <commands, tools, citations, files inspected>
**Result:** PASS | FAIL | PARTIAL | AMBIGUOUS | NOT_RUN
**Per-Claim Breakdown:**
- [x] C1: <claim> — <evidence ids> — PASS
- [ ] C2: <claim> — <evidence ids> — FAIL/PARTIAL/AMBIGUOUS
**Baseline State:** <git/artifact/context baseline if relevant>
**Evidence Pointers:** <hashes, paths, citations, resource ids>
**Residual Risk:** <unchecked items>
**Next Action:** <minimal corrective action>
```

If the workflow also needs a full human-readable report, provide both or attach the full report separately.
