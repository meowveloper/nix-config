# Agent Instructions

## 🛠 Critical Commands
- **Apply Changes**: `sudo nixos-rebuild switch --flake "path:$(pwd)#nixos"`
  - **Crucial**: `user-settings.nix` is gitignored. Using `path:` prefix is required for Nix to see it.
  - **Target**: The default hostname in `flake.nix` is `nixos`.

## 🏗 Architecture
- **Entrypoints**: `flake.nix` (root), `configuration.nix` (system), `home.nix` (user).
- **Settings**: `user-settings.nix` is the source of truth for `username1`, `username2`, and `dotfiles_path`. It is injected into all modules as `userSettings`.
- **Modularity**:
  - System modules: `modules/system/*.nix`
  - Home-manager modules: `modules/home/` (entry at `modules/home/default.nix`)

## 📜 Conventions
- **Function Arguments**: Use `{ inputs, userSettings, ... }:` for most modules.
- **Imports**: Prefer relative paths.
- **State Version**: `25.11` (System & Home).

## ⚠️ Gotchas
- **Gitignored Files**: `user-settings.nix` is gitignored. Always `read` it before assuming usernames or paths.
- **Mutable Dotfiles**: Many dotfiles are managed via `mkOutOfStoreSymlink` pointing to `userSettings.dotfiles_path`. Changes there are immediate but bypass the Nix store.
- **Hardware**: `hardware-configuration.nix` is machine-specific.
- **Build Limits**: `max-jobs` and `cores` are capped at 4 in `modules/system/nix-settings.nix` to prevent overheating.
- **Unpatched Binaries**: `nix-ld` is enabled for non-Nix binaries.

## 🔍 References
- See `.agent/GEMINI.md` for Nix/Home-Manager conceptual overview.
