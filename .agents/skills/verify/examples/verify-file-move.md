# Example — Verify a File Move

## Claim ledger

| ID | Claim | Expected Evidence |
|---|---|---|
| C1 | `old/path.md` was moved to `new/path.md`. | Source absent, destination present, content equivalent or expected diff, git status/diff shows move/delete/add. |

## Checks

```sh
test ! -e old/path.md
test -f new/path.md
git status --short
git diff --name-status
```

## Negative check

Search for stale references to `old/path.md`.

```sh
grep -R "old/path.md" . --exclude-dir=.git
```
