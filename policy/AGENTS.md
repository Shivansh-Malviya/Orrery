---
module: policy
last_updated: 2026-06-07
---
# Policy

Policy overrides lower-level instructions.

## Scope

Policy defines the governing rules: doctrine, contracts, verification gates, stage gates, registries.

## Authority

Root policy > domain OS instructions > project instructions > tool-native instructions > harness preferences.

## Structure

- `decisions/` — Architecture Decision Records (ADRs)
- `gates/` — Stage gate definitions (gate-a through gate-d, phase-completion)
- `registry/` — System registries (system-registry.yaml, skill-registry.yaml, policy-hooks.json)
- `lifecycle.md` — Governance lifecycle
- `operating-model.md` — Operating model
- `principles.md` — Guiding principles
- `review-gates.md` — Review gates

## Cross-references

- `tools/registry.md` — Tool routing registry
- `workspace/*/AGENTS.md` — Domain-specific policy overrides
