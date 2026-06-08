---
name: "Verification Gates"
description: "Use when validating plans or execution results; enforce evidence and ambiguity checks."
---
# Verification Gates

Apply these gates at the end of each request cycle.

## Mode Behavior
- Planning mode: verify that the generated plan faithfully represents the original user request, constraints, exclusions, and acceptance criteria.
- Execution mode: verify each material claim by mapping it to evidence, and provide confidence only when uncertainty materially affects action or risk.

## Gate 0: Plan Fidelity Check (Planning Mode)
- Confirm the plan reflects user objective, constraints, exclusions, deliverables, and acceptance criteria.
- Flag drift or omitted requirements before any final plan is returned.

## Gate 1: Requirement Coverage Audit
- List all user requirements.
- Mark each as `covered`, `partially covered`, or `not covered`.
- Explain any partial or missing coverage.

## Gate 2: Source Coverage Check
- Map each high-impact claim to concrete evidence.
- Evidence types: file path, tool output, command output, or explicit user-provided data.
- In execution mode, include a confidence tag only for claims where uncertainty materially affects outcome.

## Gate 3: Missing Link Check
- Identify unresolved references, implicit dependencies, and dangling steps.
- If unresolved links affect correctness, emit `HALT`.

## Gate 4: Ambiguity Check
- List terms that can be interpreted in more than one way.
- Resolve with explicit assumptions or user confirmation.

## Gate 5: Risk Summary
- Record behavior/regression risks introduced by the current request.
- State mitigation or follow-up checks.

## Gate 6: Misinterpretation/Hallucination Check
- Identify statements that are not backed by evidence.
- Mark each as `verified`, `assumption`, or `unsupported`.
- If high-impact statements are `unsupported`, emit `HALT` and request required evidence.

## Execution Closure Requirement
- Before closing execution work, provide an explicit `claim -> evidence` mapping for all high-impact outcomes.
- If any critical claim lacks evidence, do not mark completion.
