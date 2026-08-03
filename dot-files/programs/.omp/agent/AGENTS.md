# Nix Devshell Requirement

This is a NixOS system. Many projects define their development environment via a `flake.nix` file at the project root.

**MUST**: Before running any bash command, you MUST check whether a `flake.nix` file exists at the root of the current project. If a `flake.nix` is present, you MUST prepend `nix develop --command` to every command.

**Examples:**

- Single command: `nix develop --command npm test`
- Chained/sequential commands: `nix develop --command bash -c "cmd1 && cmd2"`

This is a firm, non-negotiable requirement. Never run a bash command directly if a `flake.nix` exists in the project.

# Git Command Restrictions

**MUST NOT** run any git write commands. Agents are ONLY permitted to run read-only git commands.

**Allowed (read-only):**
- `git status`
- `git diff`
- `git log`
- `git show`
- `git branch` (list only)
- `git remote` (list only)
- `git stash list`
- `git tag --list`

**Forbidden (write):**
- `git commit`
- `git add`
- `git push`
- `git checkout`
- `git merge`
- `git rebase`
- `git reset`
- `git stash` (create/apply/pop)
- `git tag` (create/delete)
- `git remote add/remove`

This is a HARD, non-negotiable rule. Any write operation must be performed by the user directly.

# Multiple Choice Preference for Questions

When using the `question` tool, always provide multiple-choice options via the `options` parameter. Even if you think the question has only one reasonable answer, still provide options — the user will select the ones that fit. This applies to all agents, not just the primary agent.

**Why:** The user prefers structured choices over open-ended text input. Multiple selections (checkboxes) keep interactions quick, scannable, and unambiguous. The user can always pick only the relevant options, but having options eliminates guesswork.

**Rule:** Every invocation of the `question` tool MUST include an `options` array with at least two labeled choices, and the `multiple` parameter SHOULD be set to `true` to allow selecting more than one option.

# Delegation Policy

The main thread's context is the shared memory of this conversation — keep it lean so long conversations stay sharp.

**Delegate, don't do.** For any substantive work (reading code, editing files, research, reviews), spawn a subagent rather than doing it yourself. A worker's context absorbs the work; only a compact report returns.

**Small, single-focus tasks → delegate directly to one specialist.** One hop, cheapest option:
- `scout` — codebase research, questions about code
- `librarian` — external libraries/APIs
- `reviewer` / `security-reviewer` — reviews
- `designer` — UI work
- `sonic` / `task` — mechanical or general edits

**Multi-part requests → delegate to the `orchestrator` agent.** It splits the work, fans out to specialists in parallel, verifies, and returns one synthesis. Use it whenever a request has several independent pieces.

**Long-running topics → keep one agent alive and message it.** Spawn the agent once, then use `hub` (or the Agent Hub, `Alt+A`) to send follow-ups to the same agent instead of re-spawning. Its context accumulates the topic's back-and-forth; yours stays small. A parked agent revives when messaged.

**Do NOT delegate:**
- Decisions, judgment calls, or quick questions that depend on this conversation's history — re-explaining to a blank-slate worker costs more than answering.
- Truly trivial responses (a one-line answer, a simple confirmation).
- Work so tightly coupled to the conversation that splitting it out would fragment the context.
