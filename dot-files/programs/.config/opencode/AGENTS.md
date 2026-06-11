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
