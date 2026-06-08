# Adapter — Local Workspace

Use when verifying files, folders, local artifacts, or project state.

## Discovery checklist

Read only what exists:

```sh
pwd
find . -maxdepth 2 -type f \( -name 'README*' -o -name 'AGENTS.md' -o -name 'CLAUDE.md' -o -name 'package.json' -o -name 'pyproject.toml' -o -name 'Makefile' -o -name 'Dockerfile' \) | sort
```

For PowerShell:

```powershell
Get-Location
Get-ChildItem -Recurse -Depth 2 -File | Where-Object { $_.Name -match '^(README|AGENTS\.md|CLAUDE\.md|package\.json|pyproject\.toml|Makefile|Dockerfile)' } | Sort-Object FullName | Select-Object FullName
```

## File change verification

- Confirm the target path exists.
- Confirm the source path if moves/deletes were claimed.
- Inspect relevant content, not only filenames.
- Search for stale duplicates.
- Check generated/build output if the source file is transformed before use.

## Workspace policy files

If policy/rule files exist, read them. Do not assume names or locations. Common names include:

- `AGENTS.md`
- `CLAUDE.md`
- `.cursor/rules*`
- `.github/copilot-instructions.md`
- `.agent/rules*`
- `docs/rules*`
- `policies/*`
