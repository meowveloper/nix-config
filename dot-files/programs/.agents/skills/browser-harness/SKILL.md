---
name: browser-harness
description: Drive the user's REAL, logged-in Chromium over CDP. Use when you need to browse the web, log into sites, keep existing logins/cookies/finished-captchas, fill forms, click elements, take screenshots, or upload files (including CV/job applications). Attaches to the already-running Chromium on port 9222 with NO --user-data-dir, so the user's real profile and sessions are preserved. Launches Chromium in the background on demand when it is not already running.
---

## 1. Ensure Chromium is running on port 9222

Do this FIRST, before using any browser tool — load the `cdp-bootstrap` skill:

> See `cdp-bootstrap` for the full ensure-CDP steps. Summary:
> `curl http://127.0.0.1:9222/json/version` → if empty `nohup chromium --remote-debugging-port=9222 >/dev/null 2>&1 &` → poll `curl` → if still dead ask user to run `chromium --remote-debugging-port=9222` manually. NEVER use `--user-data-dir`.

Follow `cdp-bootstrap` exactly; do not duplicate its launch logic here.

## 2. Drive the browser (tool names)

- drive the browser using "browser-harness" mcp to complete the task

## Gotchas

- Because we attach over CDP this IS the user's real browser session — cookies,
  logins, and already-finished captchas persist. Prefer reusing the existing
  session rather than re-authenticating.
- One Chromium per profile at a time. If the MCP fails with connection errors,
  the browser may be restarting — wait a few seconds and retry.
- Leave the launched browser running after you finish (it is the user's daily
  browser); only close individual tabs with. Do not quit the whole
  browser unless the user asks.
