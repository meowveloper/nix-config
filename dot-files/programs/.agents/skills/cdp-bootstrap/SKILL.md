---
name: cdp-bootstrap
description: Ensure Chromium is running with remote debugging on port 9222 for CDP. Use before any browser automation that needs CDP (browser-harness, agent-browser).
---

# CDP Bootstrap — ensure Chromium on port 9222

Run this FIRST before any CDP-based tool (`browser-harness` MCP, `agent-browser --cdp 9222`).

## Steps

1. Check whether CDP is already up. If this returns a Chrome banner, done:
   ```bash
   curl -s --connect-timeout 2 http://127.0.0.1:9222/json/version
   ```
2. If nothing answers, check whether the user's own browser is open:
   ```bash
   pgrep -f chromium
   ```
   - If a Chromium is alive but NOT listening on 9222, it is the user's normal browser on the shared profile. A second instance on the same profile hands off and never opens CDP. Poll every 30s for up to 10 minutes, or ask the user to close it. NEVER kill it.
3. Launch in the BACKGROUND so the session is not blocked:
   ```bash
   nohup chromium --remote-debugging-port=9222 >/dev/null 2>&1 &
   ```
   - NO `--user-data-dir` — one would isolate a fresh profile and lose the user's logins.
4. Poll until ready (up to ~60s):
   ```bash
   for i in $(seq 1 30); do curl -s --connect-timeout 2 http://127.0.0.1:9222/json/version >/dev/null && break; sleep 2; done
   ```
5. If it still does not come up, ask the user to launch it manually:
   ```
   chromium --remote-debugging-port=9222
   ```
   Then re-check `curl http://127.0.0.1:9222/json/version` until it answers. If `pgrep -af remote-debugging-port` is empty but `~/.config/chromium/SingletonLock` remains, clear stale locks if the process is absent (`rm -f ~/.config/chromium/SingletonLock ~/.config/chromium/SingletonCookie ~/.config/chromium/SingletonSocket`) then retry once. A headed browser needs an active login session (DISPLAY).
