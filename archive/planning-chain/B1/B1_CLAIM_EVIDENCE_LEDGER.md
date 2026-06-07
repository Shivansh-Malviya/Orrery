| Claim | SourcePath | LineAnchor | VerifierCommand | Status | FreshnessAgeDays |
|---|---|---:|---|---|---:|
| B1 scope lock enforced | F:\BROS_SYSTEM\governance\AGENTS.md | 11 | read_file AGENTS.md 1-20 | Verified | 3.38 |
| Write scope lock enforced | F:\BROS_SYSTEM\bootstrap\B1\B1_IMPORT_MANIFEST.csv | 1 | run_in_terminal Get-ChildItem F:\BROS_SYSTEM\bootstrap\B1\B1_* -File | Verified | 0 |
| No B2+ execution | F:\BROS_SYSTEM\bootstrap\B1\B1_IMPORT_MANIFEST.csv | 1 | run_in_terminal Get-ChildItem F:\BROS_SYSTEM -Filter B2_* -File -Recurse | Verified | 0 |
| C2 severity table immutability preserved | F:\BUTLER_AUDIT_SANDBOX\meta_execution_program\cycle_outputs\C2\severity_validation_log.md | 38 | run_in_terminal C2 exact-value equality check (rows=30,equality=true,hash=511bf92ba68b646e8628fcae50f70c314003dcc1fd23f8eb109fe0e1e2da3bff) | Verified | 23.16 |
| Freshness rule enforced for claims older than 7 days | F:\BROS_SYSTEM\governance\verification-gates.instructions.md | 22 | read_file verification-gates.instructions.md 15-22 | Verified | 26.98 |
| Blocker evaluation completed | F:\BROS_SYSTEM\bootstrap\B1\B1_BLOCKER_REGISTER.md | 1 | read_file B1_BLOCKER_REGISTER.md 1-20 | Verified | 0 |
