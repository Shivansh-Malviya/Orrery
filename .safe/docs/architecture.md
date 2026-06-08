# Orrery System Architecture

## Layers

```
Orrery root       = OS/control plane
.agents/          = Agent platform resources (rules, user context, protocols)
.context/         = Project-level designator protocol state
.safe/            = Absolute-canon content (THIS DIR)
system/           = Runtime subsystems (enforcer, scheduler, learner)
governance/       = Governance records, lifecycle, policies
hooks/            = Pre-commit, scheduled, trigger hooks
policy/           = Rules of engagement, output path policy
```

## Key Design Decisions

1. **Harness-agnostic** — No dependency on any single agent platform
2. **Designator protocol** — Session manifests over file locks for parallel agents
3. **Global identity in .agents/user/** — Not in system/context/
4. **Canonical source at F:\Bros\opencode\canonical/** — Single source of truth
5. **Per-project .context/** — Operational state at project scope, not global

## Migration History

Successor to BROS (F:\BROS_SYSTEM). Migration phases B0-B3 complete.
See `F:\BUTLER_ROOT\00_SYSTEM\BROS_MIGRATION\` for planning chain.
