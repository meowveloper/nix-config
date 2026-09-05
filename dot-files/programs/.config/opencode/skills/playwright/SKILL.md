---
name: playwright
description: Drive headed Chromium via the "playwright" MCP server (playwright-mcp) with a persistent profile. Use when you need to navigate pages, click/type by ref, handle tabs and dialogs, wait for content, pause for user login, or upload/download files. Headed by default; headless only on explicit user request.
---

# Playwright (headed Chromium via MCP)

The `playwright` MCP server (`playwright-mcp`) is configured with a persistent
profile. The browser window is visible (headed) by default so the user can watch
and take over for logins. Use headless only when the user explicitly asks for it.

## 1. Profile and lifecycle (MCP owns the browser)

Config in `opencode.jsonc`:

```jsonc
{
  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["playwright-mcp", "--browser", "chromium", "--user-data-dir", "{env:HOME}/.cache/playwright-mcp-profile"],
      "enabled": true,
      "environment": {
        "PLAYWRIGHT_MCP_USER_DATA_DIR": "{env:HOME}/.cache/playwright-mcp-profile"
      }
    }
  }
}
```

Rules:

- MCP owns the browser lifecycle. Do NOT launch a manual chromium against
  `{env:HOME}/.cache/playwright-mcp-profile` while MCP holds it — one writer
  per profile at a time or you hit `SingletonLock` / profile corruption.
- A headed browser needs an active login session (`DISPLAY`). If tools report
  no display / no browser, stop and tell the user instead of forcing headless.
- Cookies and logins in the profile persist across runs. Reuse them; leave the
  session logged in when finished.
- Call `browser_close` only at the very end of the task or when the user
  explicitly asks. Never close mid-task (especially during login-pause).

## 2. Drive the browser (tool names)

Workflow pattern:

`browser_navigate` -> `browser_snapshot` (get refs) -> `browser_click` /
`browser_type` / `browser_press_key` by ref -> re-`browser_snapshot`.

- `browser_navigate` — go to a URL.
- `browser_snapshot` — read the page as an accessibility snapshot; elements
  carry `ref`s you act on. Refs expire after each navigation or action, so
  re-snapshot before every new act step. Prefer this to inspect a page.
- `browser_click` (by ref), `browser_type` (by ref), `browser_press_key`,
  `browser_hover`, `browser_select_option`, `browser_drag` — interact by ref.
- `browser_evaluate` — reads only (extract text, URLs, state). Do NOT use it
  to click, fill, or mutate the page; use the ref-based action tools instead.
- `browser_tabs` (`list` / `new` / `select` / `close`) — manage tabs in the
  same profile session.
- `browser_handle_dialog` — accept/dismiss native dialogs.
- `browser_navigate_back` — history back.
- `browser_resize` — resize the window if a page needs a wider viewport.
- `browser_network_requests` / `browser_network_request` — inspect traffic
  when a click produces no visible change.

## 3. Waits

- `browser_wait_for` with `text` — wait for expected content to appear.
- `browser_wait_for` with `textGone` — wait for spinners/overlays to disappear.
- `browser_wait_for` with `time` — short fixed pause only when nothing else
  matches (e.g. animation); prefer text/textGone.
- After any submit or file action, wait for the confirmation marker
  (toast, thumbnail, "Download ready", URL change), then re-snapshot to verify.
- For downloads, wait for the Download event / completion indicator and use
  the returned path (under the artifacts dir).

## 4. Login-pause flow (user takes over, you wait)

When a page shows Sign in / Log in / SSO / captcha / 2FA:

1. STOP. Do NOT fill credentials, do NOT guess passwords, do NOT call
   `browser_close`. Keep the headed window open on the login page.
2. Notify the user via the `question` tool so they can log in manually.
   Always include options (Done / Skip / Abort). Example:
   `question("Login needed in the open Chromium window — <site>. Log in manually, then pick Done.", options=[Done, Skip, Abort])`.
3. Wait for their answer:
   - Done -> re-`browser_snapshot` and verify a logged-in marker (avatar,
     account name, dashboard URL, absence of Sign in) before continuing.
   - Skip -> continue with whatever is publicly visible; note the limitation.
   - Abort -> stop cleanly; leave the window as-is unless the user asks to close.
4. Never store secrets, tokens, or session values in files or logs.

## 5. Uploads

1. `browser_snapshot`, then `browser_click` the picker/button that opens the
   native file chooser.
2. Call `browser_file_upload` with absolute local paths (`paths: ["/abs/path"]`).
   Omit `paths` only to cancel the chooser.
3. Re-`browser_snapshot` and verify thumbnails / file names / success toast
   before submitting.

## 6. Downloads

- Trigger the download action, then wait for completion via `browser_wait_for`.
- Use the path returned by the download result (artifacts dir) for any
  follow-up reads; do not guess filenames.

## Gotchas

- Refs go stale fast — if an action fails with a bad ref, re-snapshot and retry once.
- One writer per profile: if the MCP reports a lock or connection error, wait
  a few seconds and retry; do not start a second browser on the same dir.
- Headed is the default. Headless only on explicit user request.
- Leave the session logged in; close with `browser_close` only at the end or on request.
