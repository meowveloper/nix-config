---
name: reorganize-dated-reports
description: "Use when reorganizing flat name-YYYY-MM-DD.md files into YYYY-MM-DD/name.md per-date directories, or any bulk dated-file migration — includes the safe bash loop, the two failure modes (greedy date extraction, nested mv), and post-migration ref-resolution checks."
---

# Reorganize flat dated files into per-date directories

When a flat set of `platform-YYYY-MM-DD.md` / `YYYY-MM-DD.md` files must become `YYYY-MM-DD/platform.md` dirs (e.g. reorganizing daily reports), use this pattern — it avoids the two bugs that bit a real migration.

## The safe loop

Run from the directory containing the files:

```bash
# main summaries: YYYY-MM-DD.md -> YYYY-MM-DD/summary.md
for f in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md; do
  [ -f "$f" ] || continue
  d="${f%.md}"; mkdir -p "$d"; mv "$f" "$d/summary.md"
done

# platform reports: platform-YYYY-MM-DD.md -> YYYY-MM-DD/platform.md
for f in *-[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md; do
  [ -f "$f" ] || continue
  d="${f##*-}"; d="${d%.md}"; mkdir -p "$d"
  stem="${f%-[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md}"   # MUST match full suffix
  mv "$f" "$d/$stem.md"
done
```

## Bugs that WILL bite (both hit in production)

1. **Greedy date extraction.** `${f##*-}` removes up to the LAST dash, so `linkedin-2026-08-08.md` yields `d="08"` (day only), files land in day-number dirs with `.md.md` double extensions. Fix: after the move, derive the date from the filename's trailing 10 chars (`date="${bare: -10}"`) and strip it with a full-suffix pattern. Never derive the date by chopping at a dash.
2. **Nested `mv` into a pre-created empty dir.** `mkdir -p daily-reports && mv src/daily-reports daily-reports/` moves the source INSIDE the target → `daily-reports/daily-reports/`. Either don't pre-create the target, or flatten with `mv nested/* . && rmdir nested` after.

## Must-do checks after migrating

- `find . -name "*.md.md"` → 0 (catches bug 1's residue)
- `ls <YYYY-MM-DD>/` shows expected files in every dated dir
- Filename references INSIDE the files (backticked `` `platform-2026-08-08.md` `` in summaries) still resolve — grep for `` `[^`]+\.md` `` and verify each ref; date-suffix stripping with `sed -E 's/-[0-9]{4}-[0-9]{2}-[0-9]{2}\.md/.md/g'` usually needed, then repair self-refs (a report naming its OWN old path) and cross-date refs (needs `../<other-date>/<file>.md`).
- Undated files that don't fit the scheme stay at root by design — say so explicitly.

## Also

- If the source dir is nested under a pre-created target, verify with `find . -maxdepth 2 -type d` before running moves.
- Report migration is mechanical; verify refs resolve, not just that the date-suffix grep is clean.
