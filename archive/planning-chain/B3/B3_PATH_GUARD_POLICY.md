| Rule | EnforcementCheck | PassCondition | FailAction |
|---|---|---|---|
| B3 scope lock | Validate all output files start with F:\BROS_SYSTEM\bootstrap\B3\B3_ | Every emitted output path matches allowed B3 prefix | HALT and emit non-compliance |
| Write allowlist | Enforce exact write targets equals three approved files | No additional writes detected | HALT and record blocker |
| Butler-root write denial | Reject any write path beginning F:\BUTLER_ROOT | Zero Butler-root write attempts | HALT immediately |
| Required inputs completeness | Require all 9 input artifacts to exist before writes | Missing input count equals 0 | HALT with missing path list |
| No B4 plus execution | Scan F:\BROS_SYSTEM for B4_* artifacts | B4_* count equals 0 | HALT and mark violation |
| Output cardinality | Validate exactly 3 B3 deliverables exist after execution | Deliverable count equals 3 | HALT and record blocker |
