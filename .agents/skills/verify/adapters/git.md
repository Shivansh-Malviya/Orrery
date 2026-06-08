# Adapter — Git and Version Control

Use when verifying commits, branches, diffs, restores, moves, deletes, releases, or repository state.

## Read-only baseline

```sh
git rev-parse --show-toplevel
git rev-parse HEAD
git status --short --branch
git diff --stat
git diff --name-status
```

## Claims and checks

| Claim | Checks |
|---|---|
| Working tree is clean | `git status --short --branch`; confirm no untracked/modified files relevant to the claim. |
| File was moved | `git status --short`, `git diff --name-status`, source missing, destination present. |
| Change was committed | `git log -1 --stat`, `git show --name-status --stat HEAD`. |
| Branch contains fix | `git branch --show-current`, `git log --oneline`, relevant file excerpt at current HEAD. |
| Restore succeeded | `git status --short`, `git diff`, target file excerpt. |
| Release/tag points to commit | `git tag --points-at HEAD`, release metadata if available. |

## Cautions

- `git status` alone does not prove correctness.
- Clean working tree only proves no uncommitted local changes.
- `git mv` metadata may not be explicit; verify source/destination content.
- Do not inspect secrets by printing their values. Report presence/path/hash, not secret contents.
