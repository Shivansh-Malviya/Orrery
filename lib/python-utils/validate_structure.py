"""Validate Orrery directory structure matches expected layout."""

import os
import sys

ROOT = os.environ.get("ORRERY_ROOT", r"F:\Orrery")

EXPECTED_DIRS = [
    ".agents/user",
    ".agents/rules",
    ".agents/Protocols",
    ".agents/skills",
    ".agents/workflows",
    ".safe/docs",
    ".safe/locked",
    ".safe/publishes",
    "etc/agents",
    "etc/defaults",
    "etc/templates",
    "governance/admission",
    "governance/context",
    "governance/hooks",
    "governance/learner",
    "governance/policy",
    "governance/start",
    "hooks/install",
    "hooks/pre-commit",
    "hooks/scheduled",
    "hooks/state",
    "hooks/triggers",
    "lib/python-utils",
    "policy/decisions",
    "policy/gates",
    "policy/registry",
    "ref/papers",
    "ref/prompts",
    "second-brain/maps",
    "second-brain/output",
    "second-brain/raw",
    "second-brain/wiki",
    "system/admission",
    "system/enforcer/controllers",
    "system/enforcer/logs",
    "system/enforcer/orchestrator",
    "system/enforcer/sentinel",
    "system/learner/patterns",
    "system/manifest/migrations",
    "system/manifest/structure",
    "system/scheduler/conditions",
    "system/start/adapters",
    "system/start/skills",
    "system/start/workflows",
    "system/state",
    "tools/adapters",
    "tools/mcp",
    "tools/scripts",
    "tools/shims",
    "tools/templates",
    "workspace/argos",
    "workspace/career",
    "workspace/education",
    "workspace/inbox",
    "workspace/lattice",
    "workspace/me",
    "workspace/research",
    "workspace/side-projects",
    "workspace/work",
]


def validate():
    errors = []
    for d in EXPECTED_DIRS:
        p = os.path.join(ROOT, d)
        if not os.path.isdir(p):
            errors.append(f"MISSING: {p}")
    if errors:
        for e in errors:
            print(e)
        sys.exit(1)
    print(f"OK: all {len(EXPECTED_DIRS)} directories present")
