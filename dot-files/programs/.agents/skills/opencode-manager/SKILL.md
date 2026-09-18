---
name: opencode-manager
description: Manage and drive opencode projects, sessions, service and models via CLI. Use when user wants to start, steer, or inspect opencode sessions.
---

# Opencode Manager

Drive opencode sessions for the user. Use simple words with examples.

## 1. Workdir + env fix
- Work in the user's current project directory (infer from conversation or ask, never assume a fixed path).
- Always prefix CLI with `XDG_DATA_HOME=/tmp/opencode-data`.
- Example: `cd <project-dir> && XDG_DATA_HOME=/tmp/opencode-data opencode session list`
- Why: else fails with EACCES on `~/.local/share/opencode/log/opencode.log`.

## 2. Service
- Commands: `opencode service status/get/start/stop`, `opencode serve --help`.
- Running at `http://127.0.0.1:3030` via `serve --service`, NOT 4096.
- Example: `XDG_DATA_HOME=/tmp/opencode-data opencode service status` -> `http://127.0.0.1:3030`
- Pair: user `opencode` / pass `opencode`.

## 3. Sessions
- List: `XDG_DATA_HOME=/tmp/opencode-data opencode session list --format json`
- Start (uses background service): `XDG_DATA_HOME=/tmp/opencode-data opencode run --format json --agent build --title "fix-x" --model opencode-go/muse-spark-1.3-contributor "Fix bug. Do not edit anything."`
- Continue: add `--continue`, `--session <id>`, `--fork`.
- NOTE v2.0.7: `opencode api "POST /session"` fails (Operation not found). `/doc` is web UI not OpenAPI JSON. Prefer CLI.
- NOTE: `opencode models` has NO `--format` flag. Use plain: `opencode models | grep muse-spark`.

## 4. Agents
- Global `default_agent=orchestrator` denies edit/shell (read/question/subagent only).
- For code edits always use `--agent build`.
- Example: `opencode run --agent build "edit foo.ts"`

## 5. Models
- Format is `provider/model`, e.g. `opencode-go/muse-spark-1.3-contributor` is built-in (27 opencode-go models, auth stored).
- Check: `opencode models | grep muse-spark`, `opencode auth list`
- Use: `opencode run -m opencode-go/muse-spark-1.3-contributor "..."`
- Custom provider shape for `opencode.jsonc`:
```json
{"provider":{"my-prov":{"baseURL":"https://.../v1","apiKey":"{env:MY_KEY}","models":{"my-model":{"name":"My Model"}}}}}
```
- Then use as `my-prov/my-model`.

## 6. Configs
- Project: `<project>/.opencode/opencode.jsonc` (per-project MCP, agents).
- Example from one playground: blender local `uvx blender-mcp`, penpot remote.
- Global: `~/.config/opencode/opencode.jsonc` (empty `provider: {}` by default).
- No root `opencode.json/yaml` needed.

## 7. Safe pattern
- Read-only test: prompt ends with `Do not edit anything.`
- Always `--title` for tracking. Example titles: `playground-test`, `model-test-muse-spark`.

## 8. SELF-IMPROVE RULE
After every task done while this skill is loaded, if you learned something worth remembering (new gotcha, version change, new flag, failure fix, working snippet), you MUST update this file's Learnings log below with date + one line. Keep short, append, never delete old learnings.

## Learnings log
- 2026-09-18: v2.0.7 `POST /session` fails, use `opencode run`; `models` has no --format; need XDG_DATA_HOME=/tmp/opencode-data; service on 3030 not 4096; default_agent orchestrator needs --agent build for edits.
- 2026-09-18: skill install needs danger-full-access to ~/.agents/skills (workspace-write blocked, subagents cannot escalate, parent must write with approval).
- 2026-09-18: keep skill workspace-agnostic, never hardcode /mnt/extra-volume/shared/random, use current project dir and mark playground configs as example only.
