---
provenance:
  canonical_for: verify
  type: PROMOTED (workflow → skill)
  winner_base: local (verify.md, score 11)
  absorbed_from: global (global_verify.md, score 10)
  verdict: local wins on 5-pass rigor, Triad Format Adapter, Recovery from Error; global wins on path-agnosticism and Memory MCP usage
  errors_fixed:
    - "References to non-existent 00_SYSTEM/scripts/sentinel.ps1 (F-01) replaced with 'run health-check skill or local test suite'"
    - "References to non-existent 00_SYSTEM/Admin/metrics.yaml (F-02) replaced with system_registry.yaml per dynamic_metrics_protocol.md"
    - "References to non-existent strategy_enforcement.md (F-03) replaced with 'check for ADR coverage in 00_SYSTEM/decisions/ADR/'"
    - "UTF-8 corruption (â–¡) replaced with ASCII □ throughout"
  loser's_unique_value: Memory MCP usage in Step 1; bounded project-relative paths
name: verify
description: "Systematic reality check. Verify that work was actually done as claimed. Cannot classify/name/move based on inference — must cite specific evidence (file path, context text, terminal output) for every decision. Multi-pass for high-stakes work."
when_to_invoke:
  explicit:
    - "User invokes /verify"
    - "User asks: 'is this done?' / 'did you actually...?' / 'is this true?'"
  auto:
    - "Before declaring any task complete (mandatory forcing function)"
    - "After file moves, deletes, or renames"
    - "Before any commit (see commit_governance_protocol.md)"
    - "After restoring from a backup or git undo (see restore skill)"
    - "When unblock or troubleshoot skill needs verification of fix"
    - "When rigor skill exits and asks to verify the work"
  triad:
    - "If active Triad session exists, wraps output in [VERIFICATION STATE] block (Step 5b)"
related_protocols:
  - "canonical/protocols/triad_protocol.md §B (Mediator uses [VERIFICATION STATE] from Step 5b)"
  - "canonical/protocols/commit_governance_protocol.md (verify is the first gate before commit)"
  - "canonical/protocols/dynamic_metrics_protocol.md (system_registry.yaml is the SoT for all metrics)"
related_skills:
  - "rigor (re-rigor if verify finds gaps in instruction adherence)"
  - "restore (if verify reveals system damage requiring undo)"
  - "unblock (verify is the third option in unblock's remediation step)"
related_files:
  - "failure_log.md (project root or 00_SYSTEM/Admin/) — lessons from past failures"
  - "system_registry.yaml — SoT for all metrics (replaces deprecated metrics.yaml)"
  - "00_SYSTEM/decisions/ADR/ — Architecture Decision Records (check for ADR coverage)"
---

# Verify Skill

Systematic reality check. Use this to verify "Did I actually do what I think I did?" or "Is this true?"

> **Evidentiary Standard:** Cannot classify/name/move anything based on inference or "best guess". Must cite specific evidence (context text, file path, metadata) for every decision.

## When to Use This Skill

- **Before declaring any task complete** (mandatory)
- **After destructive operations** (deletes, renames, moves, restructures)
- **Before any commit** (forcing function; see `commit_governance_protocol.md`)
- **When rigor skill exits** and asks you to confirm the re-framed work was actually done
- **When restore skill is invoked** — verify the post-restore state is intact
- **When user catches an oversight** — verify the corrected work is actually corrected

## When NOT to Use This Skill

- **Discovery** ("what's in this project?") — use `health-check` skill instead
- **Behavioral re-calibration** ("you're not following instructions") — use `rigor` skill instead
- **Naming a file** — use a single `Test-Path` + content peek, not the full 5-pass

---

## Steps

### 1. Analyze Context & Intent (The "Red Team" Phase)

```powershell
# Load project context (project-relative)
if (Test-Path ".agent\backlog.md") { Get-Content ".agent\backlog.md" }
if (Test-Path ".agent\logs") { Get-ChildItem ".agent\logs\*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 2 | ForEach-Object { Get-Content $_.FullName } }
if (Test-Path "README.md") { Get-Content "README.md" }
```

Also leverage Memory MCP for past context:
```
mcp_memory_search_nodes: query="context OR verify OR rules"
```

If running in BUTLER_ROOT specifically, also load:
```powershell
Get-Content F:\BUTLER_ROOT\00_SYSTEM\global_rules.md
Get-Content F:\BUTLER_ROOT\.agent\rules.md
```

- **Adversarial Check:** "If I wanted to break this, how would I do it?"
- **Anchor Check:** "Does this verify the *right* thing based on backlog anchors?"
- **Implicit Suggestion:** This verify step implicitly triggers the analysis phase of `/suggest`. If you find a flaw, you MUST PROPOSE a fix.

### 2. Define Verification Strategy

Select methods based on the target:

| Target | Method |
|--------|--------|
| **System Health** | If BUTLER_ROOT, run `health-check` skill. Otherwise, run local test suite (`npm test`, `pytest`, etc.) |
| **File Existence** | `Test-Path`, `Get-ChildItem` |
| **Registry** | Read `system_registry.yaml` and cross-check with `00_SYSTEM/decisions/ADR/` (NOT the deprecated `metrics.yaml` or `strategy_enforcement.md`) |
| **ADR Coverage** | `Get-ChildItem "00_SYSTEM/decisions/ADR" -Filter "*.md" \| Measure-Object` to confirm ADRs exist for major decisions |
| **Post-Restore** | See `restore` skill Step 4; verify the level (0-4) was applied correctly |

### 3. Execute Verification (The "Show Me" Phase)

Run the selected commands. **Do not simulate.**
- Actually run the script.
- Actually list the files.
- Actually grep the content.

### 4. Analyze Evidence

- **Pass:** Evidence matches expectation exactly.
- **Fail:** Evidence contradicts expectation.
- **Ambiguous:** Evidence is inconclusive → **escalate investigation**.

### 5. Report Findings

Output a structured report:

```markdown
# Verification Report: [Topic]

## Checked
- [x] Claim 1: [Method used] -> [Result]
- [ ] Claim 2: [Method used] -> [Result]

## Evidence
- `path/to/file`: confirmed exists
- Test Output: "Success" (or error log)

## Verdict
[PASS / FAIL / WARNING]
Action items if failed.
```

### 5b. Triad Format Adapter (Active Triad Sessions Only)

```powershell
# Check for active Triad sessions (multiplexed)
$triadsDir = ".agent/triads"
if (Test-Path $triadsDir) {
    $triadFiles = Get-ChildItem $triadsDir -Filter "*.json" -Exclude "session.schema.json"
    if ($triadFiles.Count -gt 0) {
        Write-Host "Triad session(s) active — wrapping output in [VERIFICATION STATE]" -ForegroundColor Yellow
    }
}
```

If active Triad session(s) exist, wrap the Step 5 report in the following block **instead of** the standard format, so the Mediator can relay it directly to the Planner:

```markdown
### [VERIFICATION STATE] (Mission: [mission_id])
**Objective Verified:** [Which Mission Objective this verifies]
**Method:** [Commands run / evidence type]
**Result:** PASS | FAIL | PARTIAL
**Per-Item Breakdown:** (list each sub-item individually)
- [x] Item 1: [command] → [result]
- [x] Item 2: [command] → [result]
- [ ] Item 3: [command] → FAILED — [reason]
**Baseline State:** [State captured BEFORE changes, e.g. git diff --stat output]
**Evidence:** [Terminal output hash or key snippet]
```

> **Note:** The standard Step 5 report still runs internally for local record-keeping. The [VERIFICATION STATE] block is the version the Mediator copies to the Planner.
> See `canonical/protocols/triad_protocol.md §B` for how the Mediator consumes this block.

---

## Multi-Pass Verification (High-Stakes Only)

> **Trigger Multi-Pass when:** file deletions, secret exposure, registry updates, post-restore verification, or any work the user has flagged as high-stakes.

### Pass 1: Reality Scan

```powershell
# List actual state from filesystem
Get-ChildItem $PWD -Recurse -Filter ".git" -Directory
Get-ChildItem ".agent\workflows\*.md"
if (Test-Path "00_SYSTEM\context\projects") { Get-ChildItem "00_SYSTEM\context\projects\*.md" }
```

Document actual counts.

### Pass 2: Ground Truth Comparison

```
□ Read system_registry.yaml (NOT the deprecated metrics.yaml)
□ Compare each metric: actual vs system_registry.yaml
□ If ANY mismatch:
  - STOP
  - Update system_registry.yaml to reality (see dynamic_metrics_protocol.md)
  - Flag which docs need updating
```

### Pass 3: Documentation Cross-Check

```
□ README.md counts = system_registry.yaml
□ If mismatch: Update doc, re-run Pass 3
```

### Pass 4: Self-Audit Questions

```
1. "What would I find if I grep for this count?"
2. "Did I check system_registry.yaml before writing any number?"
3. "What files reference this that I might have missed?"
4. "If someone spot-checks my work, what would they catch?"
5. "Did I use scanall or did I sample?"
6. "What did I assume rather than verify?"
7. "Can I cite the specific line/path that proves this?"
```

### Pass 5: Adversarial Stress Test (The "Loophole Check")

```
1. Input "NULL" or "Empty String": Does it crash?
2. Input "Future Date": Does it mess up chronology?
3. "Etc" Test: Did I expand the examples?
4. Registry Test: Did I update system_registry.yaml for new files?
5. Re-rigor Test: If I re-run /rigor, does it find any instruction I missed?
```

---

## Forcing Functions

### Before Completing Any Document

```
MANDATORY STEPS (cannot skip):
1. Open system_registry.yaml
2. Run verification commands
3. Compare output to system_registry.yaml
4. List all files that reference these metrics
5. Check each file
6. If wrong, update and repeat
7. Git status - review changes
```

### Before Any Commit

```
□ git status - review every changed file
□ For each file: "Does this need to be updated?"
□ Did I update system_registry.yaml if counts changed?
□ Did I propagate to all docs?
□ See commit_governance_protocol.md for the commit message format
```

---

## Red Flags (Auto-Stop)

If you notice these, STOP immediately:
- Writing a number without checking system_registry.yaml
- Declaring "done" without running verification
- Updating one doc but not checking others
- Copying counts from memory instead of checking
- Skipping verification "because it's minor"

---

## Recovery from Error

When user catches an oversight OR you catch your own mistake:

**MANDATORY FIRST QUESTION:**
> "How can I make sure this never happens again?"

Then:
1. **For instruction-adherence gaps** → invoke `rigor` skill to re-calibrate
2. **For system damage** (wrong file deleted, bad commit) → invoke `restore` skill (Level 1-4 depending on damage)
3. **For repeated failure patterns** → add check to `failure_log.md` (or `system_registry.yaml` observations)
4. **Document** what verification step would have caught it
5. **Run full verification on corrected work**
6. **Commit fix + improved verification**

---

## Classification Hierarchy (From Past Failures)

When classifying ambiguous files:
1. **Priority 1:** Project name in filename
2. **Priority 2:** Document Header/Title (first 5 lines)
3. **Priority 3:** Keyword density (LAST RESORT, low confidence)

**Never** use keyword density alone.

---

## Examples

### Verify a Move
1. **Context:** Just moved files to `Archive/`.
2. **Strategy:** Check source is empty, destination has files.
3. **Command:** `ls source`, `ls destination`.

### Verify Code Fix
1. **Context:** Fixed a bug in `calc.py`.
2. **Strategy:** Run `calc.py` with the failing input.
3. **Command:** `python calc.py`.

### Verify Cleanup
1. **Context:** "Deleted all .tmp files."
2. **Strategy:** Search for any remaining `.tmp` files.
3. **Command:** `Get-ChildItem -Recurse -Filter *.tmp`.

### Verify Post-Restore
1. **Context:** Just ran `restore` Level 1 (`git restore .`)
2. **Strategy:** Check the working tree matches the last commit
3. **Command:** `git status` (should be clean) + `git diff HEAD` (should be empty)

---

## Related Files (Cross-Reference Map)

- `failure_log.md` (project root or `00_SYSTEM/Admin/`) - Lessons from past failures
- `system_registry.yaml` - Source of truth for all metrics (replaces deprecated `metrics.yaml`)
- `reusable_strategies.md` - Pattern library including Classification Hierarchy
- `canonical/protocols/triad_protocol.md` - How the Mediator consumes Step 5b output
- `canonical/protocols/commit_governance_protocol.md` - Commit message format + verify-before-commit gate
- `canonical/protocols/dynamic_metrics_protocol.md` - Why system_registry.yaml is SoT
- `canonical/skills/rigor/SKILL.md` - Re-calibration when verify finds instruction-adherence gaps
- `canonical/skills/restore/SKILL.md` - Undo with safety levels when verify reveals system damage
- `canonical/skills/unblock/SKILL.md` - "Stuck?" workflow that calls verify as Step 3 Option C
