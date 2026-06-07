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
