# Review Gates

## Gate levels

| Level | When | Who | Examples |
|-------|------|-----|----------|
| L1 — Self-serve | Trivial, reversible | Any agent | Typo fix, adding .gitkeep, updating metadata |
| L2 — Peer check | Moderate impact | Human or secondary agent | New .context/ file, rule update |
| L3 — Governance review | Structural change | Human only | Locked doc change, root dir restructure |

## Path-based gate mapping

| Path | Gate level |
|------|-----------|
| `.safe/locked/*` | L3 |
| `.safe/docs/*` | L2 |
| `governance/*` | L2 |
| `policy/*` | L2 |
| `system/*` | L2 |
| `.agents/rules/*` | L1 |
| `.agents/user/*` | L1 |
| `workspace/**/.context/*` | L1 |
