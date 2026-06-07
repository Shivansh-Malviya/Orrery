> **Historical note:** This is the pre-Orrery BROS_SYSTEM version of
> OUTPUT_PATH_POLICY. It has been **superseded** by the active policy at
> `F:\Orrery\policy\OUTPUT_PATH_POLICY.md`. Do not use this version as
> active policy. It is preserved here for historical reference only.
>
> Key differences from the active Orrery version:
> - Runtime root was `F:\BROS_SYSTEM\`; active root is `F:\Orrery\`.
> - This version forbids writes to `F:\BUTLER_ROOT\`; the active version
>   allows reads of any non-secret path and does not generally forbid writes.
> - The envelope rule here was for the BROS contract-template context;
>   in Orrery it is scoped to specific contract-template tasks only.

# BROS Output Path Policy

## Runtime Root
- Active system root: `F:\BROS_SYSTEM`
- Active phase root: `F:\BROS_SYSTEM\bootstrap`

## Write Rules
- Allowed writes MUST stay under: `F:\BROS_SYSTEM\bootstrap\<PHASE>\`
- Forbidden write root: `F:\BUTLER_ROOT\`
- If any computed write target starts with `F:\BUTLER_ROOT\`, emit `HALT` and stop before writes.

## Read Rules
- Read-only dependencies from `F:\BUTLER_ROOT` are allowed only when explicitly listed in contract inputs.
- Never infer output paths from evidence `SourcePath` fields.

## Scan Scope Rules
- Runtime scans should target `F:\BROS_SYSTEM\bootstrap\` and `F:\BROS_SYSTEM\governance\`.
- Exclude archive roots from runtime logic: `F:\BROS_ARCHIVE\`.

## Envelope Rules
- Response should contain only the final status line + strict JSON completion block unless contract explicitly allows additional text.
