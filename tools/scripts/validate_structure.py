#!/usr/bin/env python3
from pathlib import Path
import sys

REQUIRED = [
    'AGENTS.md', 'README.md', '.agents/README.md',
    'tools/registry.md', 'second-brain/README.md',
    'workspace/lattice/AGENTS.md', 'workspace/argos/AGENTS.md',
    'workspace/work/AGENTS.md', 'workspace/work/WORK_HOME.md',
    'system/manifest/structure/current.manifest.md',
    'system/manifest/renames.manifest.md',
]
FORBIDDEN = [
    '.agents/AGENTS.md', '.agents/Protocols', 'SECOND_BRAIN',
    'vaults/dendron', 'governance/enforcer', 'governance/scheduler',
    'governance/state', 'workspace/pd', 'workspace/career/acos',
]
CONTEXT = [
    '.context/project.md', '.context/brain_dump.md', '.context/todo.md',
    '.context/backlog.md', '.context/ideas_tracker.md', '.context/changelog.md',
    '.context/failure_log.md', '.context/promotion_queue.md', '.context/README.md',
]

def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else '.').resolve()
    missing = [p for p in REQUIRED + CONTEXT if not (root / p).exists()]
    forbidden = [p for p in FORBIDDEN if (root / p).exists()]
    if missing:
        print('Missing required paths:')
        for p in missing:
            print(f'- {p}')
    if forbidden:
        print('Forbidden/deprecated paths still present:')
        for p in forbidden:
            print(f'- {p}')
    if missing or forbidden:
        return 1
    print('Orrery structure validation passed.')
    return 0

if __name__ == '__main__':
    raise SystemExit(main())
