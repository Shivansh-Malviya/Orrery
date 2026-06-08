# 04 — Execution Rules

## Capability probe

Do not assume shell access. First determine which channels are available. If local shell is required but unavailable, provide exact commands for the user to run.

Use separate command forms per environment. Do not mix PowerShell syntax with POSIX shell syntax in one executable block.

## Command execution discipline

When running commands:

- run in the correct working directory;
- avoid destructive commands unless explicitly required and authorized;
- prefer read-only checks for verification;
- capture stdout, stderr, exit code, timestamp, cwd, and command string;
- treat timeout/nonzero exit as evidence, not as something to hide;
- do not summarize away material errors;
- do not print secrets or sensitive private data; use hashes, redacted snippets, or metadata-only evidence when raw output may expose sensitive content.

## Raw-output handling

Capture enough raw output for reproducibility, but do not dump large or sensitive outputs into reports. Prefer hashes plus short relevant excerpts when output contains secrets, credentials, private records, proprietary data, or excessive logs.

## Suggested local command discovery

Use available manifests to infer commands, but do not invent success:

- JavaScript/TypeScript: inspect `package.json` scripts, then run relevant `npm/pnpm/yarn` scripts.
- Python: inspect `pyproject.toml`, `pytest.ini`, `tox.ini`, `requirements*.txt`, then run targeted `pytest`/module checks.
- Rust: `cargo test`, `cargo check` when `Cargo.toml` exists.
- Go: `go test ./...` when `go.mod` exists.
- Java/Maven: `mvn test` when `pom.xml` exists.
- Generic: `make test`, `make build`, or documented commands when `Makefile`/README specify them.

## Manual command request

If a required command cannot be run, respond with:

````markdown
I cannot execute the required command in this environment. Please run the following from `<cwd>` and paste the full output:

```sh
<command>
```

This check is required because: <claim/evidence gap>.
````

Do not use the exact stop phrase for non-shell verification when other evidence channels are sufficient.
