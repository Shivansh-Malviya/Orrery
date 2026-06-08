# Adapter — Web, Remote Systems, APIs, and Connectors

Use for claims about current facts, remote state, deployments, inbox/calendar/drive items, CI, issues, pull requests, cloud resources, or APIs.

## Source priority

1. Authenticated connector/API read when the claim concerns the user's private resource.
2. Official/primary source for public current facts.
3. Reputable secondary sources for context or contradiction checks.
4. User-supplied screenshots/logs as supporting evidence only unless no better access exists.

## Required metadata

- retrieval timestamp;
- source URL/resource id or connector pointer;
- source date/version where available;
- query/filter used;
- permissions/access limitations;
- conflict/contradiction notes.

## Remote-state cautions

- Screenshots may be stale.
- Web pages may be cached.
- Local builds do not prove deployment.
- CI success on one branch does not prove production state.
- API list results may be paginated.
- Connector search may omit archived/deleted/private items depending on scope.

## Credentials

Do not ask the user to paste raw credentials. Use existing authorized connectors/tools, or ask for redacted logs/artifacts when direct access is unavailable.
