---
manifest: system-changelog
type: changelog
last_updated: 2026-06-07
---

# System changelog

Records each logical step (commit) of the initial Orrery state. This is
the system-level changelog; per-project changelogs live in
`.context/changelog.md` (per the designator protocol).

## Initial state (2026-06-07)

The initial state was committed as 12 logical OC- commits plus the
pre-existing LICENSE, each covering one concern. Per user direction,
the "single commit per logical step" pattern is preserved here for
review.

### Steps

| # | Subject | Files | Hash |
|---|---------|-------|------|
| 0 | Initial commit (LICENSE) | 1 | d2cf7bb |
| 1 | OC-Chore: add .gitignore with BROS conventions | 1 | 15c62fa |
| 2 | OC-Docs: root entry-point docs (AGENTS.md, README.md) | 2 | f7fe1e7 |
| 3 | OC-Docs: agent contract hierarchy (3 scopes) | 10 | 0c2c815 |
| 4 | OC-Docs: system manifest (renames, migrations, structure) | 4 | f243aab |
| 5 | OC-Feat: designator protocol at root (.context/) | 10 | 1a9b0b9 |
| 6 | OC-Feat: designator protocol per module (8 × 9 stubs) | 72 | 3d5fe59 |
| 7 | OC-Feat: protocol stub at root (.agents/Protocols/) | 1 | 34e9695 |
| 8 | OC-Feat: protocol stub per module (8 modules) | 8 | efaebc1 |
| 9 | OC-Docs: additional initial manifests (this file + 3) | 4 | fabee1c |
| 10 | OC-Chore: capture BROS shell structure (12 dirs with root docs) | 12 | a9c4a48 |
| 11 | OC-Chore: populate BROS shell dirs (12 AGENTS.md + 38 .gitkeep + changelog sync) | 51 | bffebf3 |
| 12 | OC-Chore: migrate BROS_SYSTEM real content to Orrery (selective, per plan) | 33 | 5a72da5 |

**Total: 209 files across 13 commits (1 LICENSE + 9 OC- initial + 1 OC- capture + 1 OC- populate + 1 OC- migrate)**

## Conventions

- Commit subjects for agent commits start with `OC-` (OpenCode)
- Commit bodies include why / what / files / verification / risks / follow-up / attribution / collaboration (per `F:\BUTLER_ROOT\AGENTS.md`)
- `OC-Chore:` for tooling/config, `OC-Docs:` for documentation, `OC-Feat:` for new features
- This changelog is updated after each commit series; per-commit hashes are recorded in the Steps table

## Post-inheritance changes

### Steps

| # | Subject | Files | Hash |
|---|---------|-------|------|
| 16 | OC-Docs: reconcile common files with Orrery_temp (intelligent merge) | 23 | 1b4e320 |
| 17 | OC-Chore: add work KNOWLEDGE.md + README.md; remove vaults/ | 5 | b49cb01 |

### 17 — OC-Chore: add work KNOWLEDGE.md + README.md; remove vaults/
- **why**: Add standard module skeleton files to workspace/work/ per user direction; remove vaults/ (kept all other flagged dirs)
- **files touched**: created workspace/work/KNOWLEDGE.md, workspace/work/README.md; deleted vaults/ (AGENTS.md, README.md, dendron/.gitkeep); updated current.manifest.md
- **verification**: 2 new files match sibling module pattern (lattice, argos); vaults/ git-rm'd
- **risks**: vaults/ referenced in root AGENTS.md? check needed
- **follow-up**: inspect validate_structure.py before running

### 18 — OC-Chore: structural audit fixes
- **why**: Remove forbidden entities, fix workspace module gaps, add YAML frontmatter, rename archive/ → BROS_Archive/, add .gitkeep to empty dirs, update validation script
- **fixes applied**:
  - Forbidden: removed .agents/AGENTS.md, governance/{enforcer,scheduler,state}, workspace/career/acos
  - Forbidden: updated validate_structure.py FORBIDDEN list (removed .agents/Protocols)
  - Workspace: added .agents/ + .context/ to argos; added KNOWLEDGE.md to career and inbox
  - Frontmatter: added YAML to second-brain/AGENTS.md, workspace/lattice/AGENTS.md, workspace/argos/AGENTS.md
  - Rename: archive/ → BROS_Archive/ (with README and manifest updates)
  - .gitkeep: added to 154 empty directories across the tree
  - Deferred: WORK_HOME.md removed from REQUIRED list per user deferral
  - Validation: updated VALIDATION.txt; validate_structure.py passes
- **verification**: `python tools/scripts/validate_structure.py F:\Orrery` returns exit 0
- **risks**: BROS_Archive/ references in archived docs still reference old path (historical, left as-is); current-filetree.manifest.md is a historical snapshot (not updated)
- **follow-up**: none blocking

### 19 — OC-Arch: policy/contract fixes (export, permissions, work restriction, tool registry, validation)
- **why**: Encode operational principles, routing, policy boundaries, and validation that the
  architecture review identified as gaps.
- **files created** (6):
  - `policy/EXPORT_POLICY.md` — cross-system export movement rules
  - `policy/TOOL_PERMISSION_POLICY.md` — tool capability vs authority principle
  - `policy/WORK_RESTRICTED_CONTEXT_POLICY.md` — WorkBrain deferred status
  - `opencode.json` — OpenCode harness bridge config
  - `second-brain/maps/index.md` — federated map router
  - `system/manifest/source-state.manifest.md` — source-state/parity doctrine
- **files modified** (7):
  - `second-brain/maps/work.md` — added restriction rules and deferred WorkBrain note
  - `workspace/README.md` — added workspace type taxonomy (6 types)
  - `workspace/career/README.md` — hardened to explicit "no canonical material" rule
  - `workspace/career/AGENTS.md` — stripped "Layout" section; added hard rule
  - `tools/registry.md` — fully permissioned with read/write/authority schema
  - `tools/scripts/validate_structure.py` — added 6 new required paths + registry keyword check
  - `system/manifest/structure/current.manifest.md` — added opencode.json, recent change entry
- **not touched**: Lattice internals, ArgOS internals, portfolio, `.context/` protocol names,
  `.agents/workflows/` (kept), new-project skill, WorkBrain full OS
- **verification**: `python tools/scripts/validate_structure.py F:\Orrery` returns exit 0
- **risks**: WorkBrain remains deferred — no full mirror of ArgOS; career bridge hardened
  but legacy subdirectories still exist on disk; opencode.json added but has no schema validation
- **follow-up**: none blocking

## Future

The system changelog will record each subsequent commit series (e.g.,
"populate .context/", "implement sync agent", "convert module to workspace").