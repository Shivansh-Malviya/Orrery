#!/usr/bin/env python3
from pathlib import Path
import sys

REQUIRED = [
    "AGENTS.md",
    "README.md",
    "opencode.json",
    ".agents/README.md",
    "tools/registry.md",
    "policy/EXPORT_POLICY.md",
    "policy/TOOL_PERMISSION_POLICY.md",
    "policy/WORK_RESTRICTED_CONTEXT_POLICY.md",
    "second-brain/README.md",
    "second-brain/maps/index.md",
    "workspace/lattice/AGENTS.md",
    "workspace/argos/AGENTS.md",
    "workspace/work/AGENTS.md",
    "system/manifest/structure/current.manifest.md",
    "system/manifest/renames.manifest.md",
    "system/manifest/source-state.manifest.md",
]
FORBIDDEN = [
    ".agents/AGENTS.md",
    "SECOND_BRAIN",
    "vaults/dendron",
    "governance/enforcer",
    "governance/scheduler",
    "governance/state",
    "workspace/pd",
    "workspace/career/acos",
]
CONTEXT = [
    ".context/project.md",
    ".context/brain_dump.md",
    ".context/todo.md",
    ".context/backlog.md",
    ".context/ideas_tracker.md",
    ".context/changelog.md",
    ".context/failure_log.md",
    ".context/promotion_queue.md",
    ".context/README.md",
]
REGISTRY_KEYWORDS = [
    "Allowed read",
    "Forbidden read",
    "Allowed write",
    "Forbidden write",
    "Authority",
]


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    missing = [p for p in REQUIRED + CONTEXT if not (root / p).exists()]
    forbidden = [p for p in FORBIDDEN if (root / p).exists()]

    registry_path = root / "tools/registry.md"
    missing_registry_keywords = []
    if registry_path.exists():
        text = registry_path.read_text(encoding="utf-8")
        for kw in REGISTRY_KEYWORDS:
            if kw not in text:
                missing_registry_keywords.append(kw)
    else:
        missing_registry_keywords = REGISTRY_KEYWORDS

    if missing:
        print("Missing required paths:")
        for p in missing:
            print(f"- {p}")
    if forbidden:
        print("Forbidden/deprecated paths still present:")
        for p in forbidden:
            print(f"- {p}")
    if missing_registry_keywords:
        print("tools/registry.md missing permission headings:")
        for kw in missing_registry_keywords:
            print(f"- {kw}")
    if missing or forbidden or missing_registry_keywords:
        return 1
    print("Orrery structure validation passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
