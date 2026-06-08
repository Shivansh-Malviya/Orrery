# Orrery_temp Federated Architecture Migration

Target commit before rewrite: `946e50b6995227cb174e8a522801887151930c7a`.
Target commit after rewrite: `98ddd5acdea6c67c6c95f653932f518b6bd882aa`.

## Renames
- `.agents/AGENTS.md` to `.agents/README.md`
- `.agents/Protocols/` to `.agents/protocols/`
- `SECOND_BRAIN/` to `second-brain/`
- `workspace/pd/` to `workspace/lattice/`
- `workspace/career/acos/` to `workspace/argos/`
- `workspace/career/` to compatibility bridge only
- `vaults/` removed from active tree

## Added
- `workspace/work/` WorkBrain
- `tools/registry.md`
- workspace `KNOWLEDGE.md` bridges
- validation script

## Validation
Command: `python tools/scripts/validate_structure.py .`
Output: `Orrery structure validation passed.`

## Risks
The disposable target previously contained a nested `orrery/` upload. This rewrite promotes the corrected architecture to repository root.
