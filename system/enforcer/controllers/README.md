# enforcer/controllers/ — Enforcer Controllers

Individual controllers that each check one type of policy violation.

## Planned controllers

- `path-integrity` — Detect hardcoded absolute paths in scripts and config
- `cross-references` — Detect broken markdown and path references
- `header-conformance` — Verify YAML frontmatter on workflow and skill files
- `consistency` — Verify file registries match filesystem reality
- `stale-context` — Detect context files exceeding freshness thresholds
