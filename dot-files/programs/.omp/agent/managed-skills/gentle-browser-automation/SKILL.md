---
name: gentle-browser-automation
description: "Drive CDP browser automation with minimal bot-detection friction (PerimeterX/Cloudflare/reCAPTCHA trust-score draining) — one tab, human pacing, batch-after-solve, stop-on-challenge."
---

# Gentle Browser Automation (bot-detection-friendly driving)

Use when driving CDP Chrome (xd://browser) on sites with bot detection — PerimeterX/Human Security "Press & Hold" (ERRCODE PXCR...), Cloudflare/Turnstile, reCAPTCHA — where automation works but triggers re-verification challenges.

## Why challenges happen
Bot-detection layers score the browser session. Automation signals drain the score: tab churn, superhuman pacing, burst navigations, CDP/automation fingerprints. The "press & hold" / Turnstile challenge is a RE-VERIFICATION, not a ban: a human solve restores trust, then it drains again under automation. Goal: be quiet enough that challenges are rare (one per session, not one per page).

## Detecting the drain signature
- Fresh session loads clean (trust carried over from last human solve), then the challenge appears mid-run right after a tab close/reopen or a burst of navigations → that's the drain.
- Challenge only on protected paths (seller dashboards, manage/edit pages) while public pages load fine.

## Protocol
1. **One persistent tab per target.** NEVER close/reopen it mid-run — tab churn is the loudest signal (observed: PX escalates browser-wide right after a reopen).
2. **Human pacing**: 1.5–3.5s randomized delay between actions (`await new Promise(r => setTimeout(r, 1500 + Math.random()*2000))`); scroll the page naturally before clicking; no instant action chains.
3. **Minimal navigations**: stay inside the target page/editor; avoid goto-bouncing between pages; prefer in-page DOM interaction over full navigations.
4. **Batch everything into ONE pass immediately after a human solve** — trust is freshest right then. Never spread work across sessions.
5. **Stop on challenge**: screenshot + report NEEDS_USER_SOLVE + STOP. Never retry or relaunch (retrying burns trust faster). The human solves once, then resume.
6. **Do not kill/restart the browser** during a run; keep sessions alive.

## Escalation
If a platform re-challenges 3+ times across runs: stop automating it. Fall back to a manual runbook (exact clicks, copy, pricing) and let the human do it.

## Notes
- CDP (`--remote-debugging-port`) is itself fingerprintable — you can't fully defeat the detector; you're minimizing friction, not bypassing.
- Reference incident: Fiverr seller setup, 2026-08 — gig editor steps 1-5 saved fine, then PX re-blocked browser-wide mid-run after tab close/reopen; three agent attempts each re-triggered it; this protocol derived from that incident.
