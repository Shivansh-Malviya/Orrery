# Orrery Tool Registry

Tools are capabilities, not authorities. Tool internals stay native.

## Registry format

Each tool entry includes:

- **Status**: active / candidate / deprecated
- **Role**: one-line description
- **Authority**: what domain (if any) this tool owns
- **Allowed read**: paths/surfaces it may read
- **Forbidden read**: paths/surfaces it must not read
- **Allowed write**: paths/surfaces it may write
- **Forbidden write**: paths/surfaces it must not write
- **Approval required**: whether explicit user instruction is needed
- **Native entrypoint**: where the tool lives

---

## HenryDaum Second Brain

- **Status**: candidate runtime/indexer
- **Role**: second-brain runtime candidate
- **Authority**: none
- **Allowed read**: approved second-brain surfaces, inbox, exported maps
- **Forbidden read**: raw ArgOS, raw work, `.safe/locked/`
- **Allowed write**: none by default
- **Forbidden write**: all canonical stores
- **Approval required**: yes for any write
- **Native entrypoint**: external

## Hermes

- **Status**: active
- **Role**: messaging/interface gateway
- **Authority**: none
- **Allowed read**: inbox, message queues
- **Forbidden read**: canonical records without approval
- **Allowed write**: inbox items, drafts, reminders if approved
- **Forbidden write**: canonical records
- **Approval required**: yes for writing canonical stores
- **Native entrypoint**: external

## ScienceClaw

- **Status**: active
- **Role**: research specialist
- **Authority**: research domain only
- **Allowed read**: research papers, research domain workspace
- **Forbidden read**: non-research canonical stores
- **Allowed write**: research notes, research domain workspace
- **Forbidden write**: non-research canonical stores
- **Approval required**: no within research domain; yes outside
- **Native entrypoint**: external

## Lattice

- **Status**: active
- **Role**: holistic personal knowledge hub
- **Authority**: owns `workspace/lattice/`
- **Allowed read**: `workspace/lattice/` and approved context interfaces
- **Forbidden read**: raw work, `.safe/locked/`
- **Allowed write**: `workspace/lattice/` and approved exports
- **Forbidden write**: ArgOS, work, canonical stores outside lattice
- **Approval required**: no for lattice internals; yes for cross-system writes
- **Native entrypoint**: `workspace/lattice/`

## ArgOS

- **Status**: active
- **Role**: Application Campaign OS
- **Authority**: owns `workspace/argos/`
- **Allowed read**: `workspace/argos/`, career/ compatibility references
- **Forbidden read**: raw work, `.safe/locked/`
- **Allowed write**: `workspace/argos/` and explicit shareable/export surfaces
- **Forbidden write**: lattice, work, other canonical stores
- **Approval required**: no for ArgOS internals; yes for cross-system writes
- **Native entrypoint**: `workspace/argos/`

## Work shim (WorkBrain deferred)

- **Status**: active (restricted)
- **Role**: restricted work-domain shim
- **Authority**: none (WorkBrain deferred)
- **Allowed read**: work export/map surfaces only
- **Forbidden read**: raw work source material
- **Allowed write**: work export/map surfaces only
- **Forbidden write**: raw work indexing, cross-system promotion
- **Approval required**: yes for any non-export operation
- **Native entrypoint**: `workspace/work/`

## OpenCode

- **Status**: active
- **Role**: coding and task harness
- **Authority**: none (harness only)
- **Allowed read**: all non-secret paths
- **Forbidden read**: `.safe/locked/` without explicit instruction
- **Allowed write**: per path policy (`policy/OUTPUT_PATH_POLICY.md`)
- **Forbidden write**: `.safe/locked/`, `.archive/`, protected paths
- **Approval required**: yes for envelope-rule tasks
- **Native entrypoint**: follows `AGENTS.md` and this registry

## Antigravity

- **Status**: active
- **Role**: agentic development harness
- **Authority**: none (harness only)
- **Allowed read**: all non-secret paths
- **Forbidden read**: `.safe/locked/` without explicit instruction
- **Allowed write**: per path policy (`policy/OUTPUT_PATH_POLICY.md`)
- **Forbidden write**: `.safe/locked/`, `.archive/`, protected paths
- **Approval required**: yes for envelope-rule tasks
- **Native entrypoint**: follows `AGENTS.md` and this registry

## VS Code / Copilot

- **Status**: active
- **Role**: editor/completion assistant
- **Authority**: none (harness only)
- **Allowed read**: all open editor paths
- **Forbidden read**: `.safe/locked/` without explicit instruction
- **Allowed write**: editor-scoped (user-initiated)
- **Forbidden write**: `.safe/locked/`, `.archive/`, protected paths
- **Approval required**: user-initiated writes only
- **Native entrypoint**: `.github/copilot-instructions.md` and applicable `AGENTS.md`
