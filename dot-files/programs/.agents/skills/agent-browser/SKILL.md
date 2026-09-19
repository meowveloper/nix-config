---
name: agent-browser
description: Fast browser automation CLI (agent-browser) via CDP. Use for navigating pages, snapshots with @eN refs, clicking/filling, uploading, downloading, waiting, and managing tabs/sessions. Connects to an existing Chromium on port 9222.
---

# agent-browser — CLI via CDP

General-purpose browser automation. Works headed or headless, with a persistent profile when launched via the CLI daemon.

## 0. Ensure Chromium on port 9222

Before any `agent-browser` command, ensure CDP is up via the `cdp-bootstrap` skill:
```bash
curl -s --connect-timeout 2 http://127.0.0.1:9222/json/version
# if empty, run:  nohup chromium --remote-debugging-port=9222 >/dev/null 2>&1 &
# if that fails, ask the user to run:  chromium --remote-debugging-port=9222
```
Wait until `curl http://127.0.0.1:9222/json/version` returns a banner. Do not use `--user-data-dir`.

## 1. Official CLI skills

Retrieve version-matched usage at runtime (never guess from stale docs):

```
agent-browser skills        List all available skills (same as skills list)
agent-browser skills list   List all available skills with names and descriptions
agent-browser skills get <name>              Output a skill's full content
agent-browser skills get <name> --full       Include references and templates alongside the skill
agent-browser skills get --all               Output every skill
agent-browser skills path [name]             Print the filesystem path to a skill directory
```

Start with `agent-browser skills get core --full` for the common loop (open → snapshot → click/fill → snapshot).

## 2. Connect via CDP

```bash
# Start Chrome with: google-chrome --remote-debugging-port=9222

# Connect once, then run commands without --cdp
agent-browser connect 9222
agent-browser snapshot
agent-browser tab
agent-browser close

# Or pass --cdp on each command
agent-browser --cdp 9222 snapshot
```

- `--cdp <port|wss://...>` accepts a local port (via http://localhost:{port}) or a full WebSocket URL.
- `--auto-connect` discovers Chrome's DevToolsActivePort or probes 9222/9229.
- `--pin-tab` pins a session to its CDP target (strict, avoids tab-steal when sharing one browser).
- `XDG_RUNTIME_DIR` must be writable: if the daemon fails `Failed to create socket directory`, use `XDG_RUNTIME_DIR=/tmp/run-test agent-browser --cdp 9222 ...` (sandbox workaround).

## 3. Core loop (snapshot + refs)

```bash
export AGENT_BROWSER_SESSION="$(agent-browser session id --scope worktree --prefix task)"
agent-browser --cdp 9222 open https://example.com
agent-browser --cdp 9222 snapshot -i
agent-browser --cdp 9222 click @e3
agent-browser --cdp 9222 fill @e3 "text"
agent-browser --cdp 9222 upload "input[type=file]" file1.pdf file2.jpg
agent-browser --cdp 9222 wait --text "Success"
agent-browser --cdp 9222 download @e5 ./out.pdf
agent-browser --cdp 9222 screenshot out.png
```

Prefer `snapshot -i` + `@eN` refs; `find role/text/label` and raw CSS are fallbacks.

## Docs

- https://agent-browser.dev/
- https://agent-browser.dev/skills
- https://agent-browser.dev/cdp-mode
