---
name: browser
description: Drive the user's REAL, logged-in Chromium over CDP using the "chrome" MCP server (chrome-devtools-mcp). Use when you need to browse the web, log into sites, keep existing logins/cookies/finished-captchas, fill forms, click elements, take screenshots, or upload files (including CV/job applications). Attaches to the already-running Chromium on port 9222 with NO --user-data-dir, so the user's real profile and sessions are preserved. Launches Chromium in the background on demand when it is not already running.
---

# Browser (real Chromium via CDP)

The `chrome` MCP server (chrome-devtools-mcp) is already configured to attach to
`http://127.0.0.1:9222`. Use its tools to drive the user's normal, logged-in
Chromium. No fresh profile, no re-login, no bot detection.

## 1. Ensure Chromium is running on port 9222 (launch on demand)

Do this FIRST, before using any browser tool.

1. Check whether CDP is already up. If this returns a Chrome banner, skip to step 4:
   `curl -s --connect-timeout 2 http://127.0.0.1:9222/json/version`
2. If nothing answers, check whether the user's own browser is open:
   `pgrep -f chromium`
   - If a Chromium is alive but NOT listening on 9222, it is the user's normal
     browser on the shared profile. A second instance on the same profile hands
     off and never opens CDP. Poll every 30s for up to 10 minutes, or ask the
     user to close it. NEVER kill it.
3. Launch in the BACKGROUND so the session is not blocked:
   ```bash
   nohup env DISPLAY=:0 chromium --remote-debugging-port=9222 --no-sandbox --disable-gpu --ozone-platform=x11 about:blank >/dev/null 2>&1 &
   ```
   - NO `--user-data-dir` — one would isolate a fresh profile and lose the user's logins.
   - Keep `--disable-gpu` and `--ozone-platform=x11`; they avoid launch crashes on this machine.
4. Poll until ready (up to ~60s):
   ```bash
   for i in $(seq 1 30); do curl -s --connect-timeout 2 http://127.0.0.1:9222/json/version >/dev/null && break; sleep 2; done
   ```
5. If it still does not come up, diagnose: `pgrep -af remote-debugging-port`, clear stale
   locks if the process is absent (`rm -f ~/.config/chromium/SingletonLock ~/.config/chromium/SingletonCookie ~/.config/chromium/SingletonSocket`),
   then retry once. A headed browser needs an active login session (DISPLAY).

## 2. Attach

The MCP server is attached to port 9222 automatically. If a tool reports "no
browser", complete Section 1 first, then retry the tool call.

## 3. Drive the browser (tool names)

- `navigate_page` — go to a URL (also has back/forward/reload)
- `new_page`, `select_page`, `list_pages`, `close_page` — manage tabs in the same logged-in session
- `take_snapshot` — read the page as an accessibility snapshot; elements carry `uid`s you can act on. PREFER this to inspect a page.
- `click` (by uid), `fill` (by uid), `type_text`, `press_key`, `handle_dialog`
- `take_screenshot`
- `upload_file` — upload a file to a native `<input type="file">` OR a custom/Shadow-DOM picker. File paths are interpreted on the browser host (the same machine here), so pass a local absolute path like `/example/absolute/path.md`.
- `wait_for` — wait for conditions on the page

Workflow pattern: `navigate_page` -> `take_snapshot` (get uids) -> `click`/`fill`
by uid -> `upload_file` where needed -> `take_screenshot` if evidence is wanted.

## Gotchas

- Because we attach over CDP this IS the user's real browser session — cookies,
  logins, and already-finished captchas persist. Prefer reusing the existing
  session rather than re-authenticating.
- One Chromium per profile at a time. If the MCP fails with connection errors,
  the browser may be restarting — wait a few seconds and retry.
- Leave the launched browser running after you finish (it is the user's daily
  browser); only close individual tabs with `close_page`. Do not quit the whole
  browser unless the user asks.
- The first `npx chrome-devtools-mcp@latest` run downloads the package (a few
  seconds); later runs are cached.
