---
name: repair-corrupted-lazy-plugin-checkout
description: Diagnose and repair a corrupted/half-updated lazy.nvim plugin checkout (git HEAD vs worktree mismatch after :Lazy update)
---

# Repair a corrupted lazy.nvim plugin checkout

Use when a `:Lazy update` leaves a plugin in a broken state: git HEAD points at an old tag/commit but the working-tree files are from a newer version, or updates keep failing with "local changes would be overwritten by checkout".

## Signature (all three together = corrupted checkout)

1. `git -C ~/.local/share/nvim/lazy/<plugin> status --porcelain | wc -l` → many modified/deleted/untracked files
2. `git -C ~/.local/share/nvim/lazy/<plugin> log -1 --format='%H %d %ci %s'` shows an OLD tag (e.g. v13.1.8) while `CHANGELOG.md` in the worktree shows newer versions
3. `git -C ~/.local/share/nvim/lazy/<plugin> reflog` shows checkouts only up to the old tag — no newer checkout ever completed
4. `lazy-lock.json` still pins the old commit → every future update fails on this dir

Typical cause: a git submodule added in a newer plugin version (check `.gitmodules`) plus pre-existing dirty files (e.g. `.busted` from a plugin's test run) aborting lazy's checkout mid-way, leaving new files applied on top of the old HEAD.

## Diagnosis commands

```bash
D=~/.local/share/nvim/lazy/<plugin>
git -C $D status --porcelain | wc -l
git -C $D log -1 --format='%H %d %ci %s'
git -C $D reflog | head -5
git -C $D diff v<LATEST_TAG> --stat -- lua/ | tail -3   # clean lua/ vs latest tag => files are newer than HEAD
python3 -c "import json; print(json.load(open('$HOME/.config/nvim/lazy-lock.json'))['<plugin>'])"
```

## Fix

```bash
rm -rf ~/.local/share/nvim/lazy/<plugin>          # safest: full clean reinstall
cd /tmp && nvim --headless -c "qa"                 # lazy auto-reinstalls missing plugins at startup
# then advance to latest (lockfile still pins old commit):
nvim --headless "+Lazy! update <plugin>" +qa
```

Alternative in-place repair (preserves nothing worth keeping):
```bash
git -C $D checkout -- . && git -C $D clean -fd
git -C $D checkout v<LATEST_TAG> && git -C $D submodule update --init --recursive
```

## Verify

- `git -C $D status --porcelain | wc -l` → 0
- `git -C $D log -1` shows the intended tag; lockfile updated to matching commit
- `nvim --headless "+lua require('lazy').load({plugins={'<plugin>'}})" "+lua require('<plugin>').version" +qa` loads without error
- Run the plugin's `:checkhealth` if it has one
