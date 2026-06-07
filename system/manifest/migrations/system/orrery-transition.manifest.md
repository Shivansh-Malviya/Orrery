---
manifest: orrery-transition
type: migration-record
last_updated: 2026-06-07
source: F:\BROS_SYSTEM\
target: F:\Orrery\
---

# Orrery transition

The story of how `F:\BROS_SYSTEM\` was replaced by `F:\Orrery\`.

## Original state (F:\BROS_SYSTEM\)

- 18 top-level directories: .agents, .git, .github, .obsidian, .safe, archive, data, etc, governance, hooks, inbox, lib, policy, ref, SECOND_BRAIN, system, tools, vaults, workspace
- 247 files (89 placeholder/stub files; ~36% placeholder ratio)
- 10 enforcer failures
- Phase gates A/C/D failing
- ~8 case-only duplicate pairs (e.g., `Admin/` vs `admin/`)
- ACOS configuration present (left in place at F:\BROS_SYSTEM\ per user direction)
- Mixed naming conventions; no uniform hidden-dir pattern

## Migration goals

1. **Clean workspace skeleton** — every dir has a documented purpose
2. **Uniform naming conventions** — kebab-case, lowercase, hidden-dir pattern
3. **BROS shell separation** — 12 control-plane dirs + 6 hidden dirs at root, content in workspace/
4. **Manifest-based system tracking** — renames, migrations, structure, AGENTS.md hierarchy
5. **YAML frontmatter convention** — applied to .manifest.md and AGENTS.md files
6. **Designator protocol integration** — .context/ at root + per module, per canonical design
7. **Harness-agnostic contract** — the workspace contract does not depend on any single agent platform

## Actual changes (BROS_SYSTEM → Orrery)

### Renames (significant)

| Old (BROS_SYSTEM) | New (Orrery) |
|---|---|
| `admin/` | `.admin/` (hidden) |
| `.contractor-ops/` | `.admin/` (merged) |
| `pet-projects/` | `.pet-projects/` (hidden) |
| `archive/` | `.archive/` (hidden) |
| `qcm/` | `quantum-computation-materials/` (full expansion) |
| `cyber-sec/` | `quantum-cybersec/` |
| `post-quantum-cryptography/` | `pqc/` |
| QCM children `qcm-*` | dropped `qcm` prefix |
| `freelance/{linkedin,mercor,...}/` | each gets `.profile/` subdir |
| `iiser-pune/`, `iit-indore/` | each gets `.admin/` and `.archive/` |
| `uelement/` | gets `.admin/` and `.archive/`, subdirs stripped |
| `dendron/` | `vaults/` (empty) + `.obsidian/` (preferred) |
| `safe/` | `.safe/` (hidden) with subdirs `publishes/`, `docs/`, `locked/` |
| `ai-prompts/` | removed (not a canon folder) |
| `academic/`, `personal/`, `ina/`, `career/`, `system/` (legacy) | `workspace/inbox/` |

### Structure additions

- `system/manifest/` — system-tracking files (renames, migrations, structure)
- `system/manifest/migrations/{.archive, project/, inter-project/, drive/, system/}` — migration type subdirs
- `workspace/{career,education,inbox,me,pd,research,side-projects,work}/` — 8 identity-facet modules
- `.context/` at root + 8 module .context/ dirs — designator protocol surface
- `.agents/{rules,skills,workflows}/` at root + per module — cross-platform agent resources
- `.agents/Protocols/` at root + per module — protocol stubs
- 6 hidden dirs (`.agents`, `.archive`, `.context`, `.github`, `.obsidian`, `.safe`) and 12 BROS shell dirs at root

### Conformance

- All top-level dirs are uniformly either `dir/` (shell) or `.dir/` (hidden)
- All hidden dirs follow the `.agents, .archive, .context, .github, .obsidian, .safe` pattern at root
- All AGENTS.md files have YAML frontmatter
- All manifest files follow `*.manifest.md` convention

## Verification

- 245 directories, 120 files at initial commit (verified via `Get-ChildItem -Recurse`)
- 10 AGENTS.md files (root, .agents, system, 8 modules)
- 9 .context/ dirs (root + 8 modules), 81 stub files
- 9 .agents/Protocols/protocol_stub.md (root + 8 modules)
- 4 system-tracking manifest files at initial commit
- 4 additional initial manifests added in commit 9 (this one + initial-commit-message + current-filetree + system-changelog)
- git initialized on `main` branch; all content untracked at start

## Future work

- Populate .context/ files with real content as the workspace is used
- Build sync agent per canonical template (out of scope for initial commit)
- Convert workspace modules to independent workspaces when ready
- Populate .obsidian/ when Obsidian is configured
- Populate .safe/{docs,locked,publishes}/ as canon content is identified
- Implement designator protocol runtime (.sessions/, designator protocol enforcement)

## See also

- `system/manifest/migrations/system/bros-to-orrery.manifest.md` — formal migration record
- `system/manifest/renames.manifest.md` — significant renames only
- `system/manifest/structure/current.manifest.md` — current structure summary
- `F:\BUTLER_ROOT\00_SYSTEM\audits\DA_2026-06-07_orrery-context.md` — DA review (out of repo)