# Conversation Log

## Session 2: Multi-User and Private Configuration
- Set up a dynamic user configuration using `user-settings.nix` (added to `.gitignore` for privacy).
- Configured both users to have full sudo privileges via the `wheel` group.
- Integrated Home Manager into `flake.nix` to manage both users simultaneously.
- Configured a shared `home.nix` that symlinks the AstroNvim configuration from `./home/.config/nvim`.

## Session 3: Neovim LSPs and Tools
- Analyzed `community.lua` to identify required language servers.
- Updated `home.nix` to install LSPs (Lua, TypeScript, Vue, Tailwind, C++, Zig, Docker) and runtime dependencies (Node.js) via Nix.
- This configuration ensures AstroNvim works on NixOS without relying on Mason for binary installation.

## Session 4: System Modularization and Cleanup
- Fully modularized `configuration.nix` into `modules/system/` (boot, network, locale, display, nix-settings).
- Fully modularized Home Manager into `modules/home/`.
- Implemented `specialArgs` in `flake.nix` to pass `userSettings` (dynamic usernames) globally to all modules, eliminating duplicate imports.
- Adopted the `assume-unchanged` Git strategy for `user-settings.nix` to balance privacy with Flake reproducibility.
- Removed the experimental `nixCats` and Neovim modules to maintain a clean, working baseline for testing.
- Discussed NixOS garbage collection and the critical role of `flake.lock`.

## Session 5: Neovim Wrapping and Modular Dotfiles
- **Wrapped Neovim Implementation**: Switched to a "Wrapped Neovim" approach, using `mkOutOfStoreSymlink` to link existing AstroNvim configurations while managing binary dependencies (LSPs, tools) through Nix.
- **Modernized LSPs**: Updated LSP package names to modern top-level equivalents (e.g., `vue-language-server`).
- **Global Terminal Tools**: Refactored `home.packages` to provide common tools (`yazi`, `lazygit`, `ripgrep`, etc.) globally rather than just within Neovim's PATH.
- **Hyprland & Yazi Modularization**: Created dedicated Home Manager modules for Hyprland and Yazi, mapping local dotfiles to standard XDG locations.
- **System-Level Hyprland**: Moved system-level Hyprland enabling to a dedicated module and added XDG portal support for better Wayland integration.
- **Activation Safety**: Added `home.backupFileExtension` to handle existing file conflicts automatically during Home Manager activation.

## Session 6: Shell & Terminal Migration and Reorganization
- **Modular Reorganization**: Refactored `modules/home/` into `programs/` and `desktop/` subdirectories for better organization and scalability.
- **Starship Migration**: Integrated the Starship prompt into Nix, linking your existing `starship.toml` and enabling shell integrations.
- **Zsh Migration**:
    - Replaced the `zinit` plugin setup with Home Manager's native `programs.zsh`.
    - Enabled syntax highlighting, autosuggestions, and completions.
    - Sourced legacy aliases and profile files from `dot-files`.
    - Integrated `fzf` and `zoxide`.
- **Tmux Migration**:
    - Replaced `tpm` with Nix-managed plugins, including the Dracula theme.
    - Migrated custom keybindings and status bar settings to `modules/home/programs/tmux.nix`.
- **System-Wide Shell**:
    - Created `modules/system/shell.nix` to set Zsh as the default login shell for all users.
    - Explicitly added `pkgs.zsh` to `environment.systemPackages` to ensure availability during `su -` sessions.
- **Cleanup**: Removed temporary `.null-ls` files and updated all relative paths in home modules to match the new directory structure.

## Session 7: Cleanup and Flatpak Integration
- **Dotfile Cleanup**: Removed redundant top-level dotfiles (`.zshrc`, `.p10k.zsh`, `.tmux.conf`, `.bashrc`) and unused configuration folders (`.tmux`, `fish`, `shell`) from the `dot-files/` directory.
- **Flatpak Implementation**:
    - Created `modules/system/flatpak.nix` to enable the Flatpak service and manage font availability.
    - Added an activation script to automatically configure the Flathub repository.
    - Resolved app launcher integration issues by explicitly adding Flatpak export paths to `XDG_DATA_DIRS`.
- **Zsh Global Availability**: Confirmed `pkgs.zsh` is in `environment.systemPackages` to ensure the shell is available globally, specifically for `su -` user switching.

## Session 8: Custom Binary Compilation and Pinning
- **Custom Zig Binary**: Integrated `meowmux` (a custom Zig project) into the Nix configuration by building it from source.
- **Zig Pinning**: Added `zig-overlay` as a flake input to pin the compiler version to strictly `0.15.2`, ensuring build reproducibility independent of `nixpkgs` updates.
- **Sandbox Build Configuration**: Implemented a custom build derivation that handles Zig's global and local cache directories within the Nix sandbox to resolve `AccessDenied` errors during compilation.
- **Ephemeral Tooling**: Demonstrated Nix's ability to use a specific compiler version during build-time without installing it globally on the system.

## Session 9: Desktop Environment Refinement and Tooling
- **Resource Optimization**: Switched from `dms` (Dank Material Shell) to a custom "Meow" desktop configuration (Hyprland + Waybar + Rofi), significantly reducing RAM and CPU usage.
- **Network Integration**: 
    - Enabled `network-manager-applet` service and installed `networkmanagerapplet` for GUI-based Wi-Fi management.
    - Configured Waybar's network module to launch `nm-connection-editor` on click.
- **Custom Wallpaper Gallery**:
    - Created a Rofi-based wallpaper selector with image previews and a grid layout (`wallpaper.rasi`).
    - Implemented `wallpaper-launcher.sh` with automatic symlink resolution (`readlink -f`) to ensure consistent thumbnail rendering.
    - Added a global Hyprland keybinding (`SUPER + U`) for instant theme and wallpaper switching.
- **GTK Integration**:
    - Created `gtk.nix` to manage GTK themes (`adw-gtk3-dark`) and icons (`Papirus-Dark`).
    - Configured `gtk.css` to import Matugen-generated colors (`colors.css`), ensuring `nm-applet` and other GTK apps match the wallpaper-based theme.
- **Window Management**:
    - Established `rules.conf` in Hyprland configuration.
    - Added window rules to ensure `nm-connection-editor` always opens as a centered, floating window (800x600).

## Session 10: Neovide Configuration and Complex Script Rendering
- **Neovide Integration**: Configured Neovide as a high-performance GUI for Neovim, enabling features like smooth animations and hardware-accelerated rendering.
- **Burmese Script Optimization**: 
    - Addressed overlapping and misaligned Burmese characters by configuring `Padauk` as a fallback font.
    - Implemented vertical spacing adjustments (`line_spacing = 1.2`) to prevent glyph collisions.
    - Researched and discussed Unicode vs. Zawgyi typing orders and their impact on text shaping.
- **Modular Neovide Config**: 
    - Created a dedicated `config.toml` and a complementary `neovide.lua` file.
    - Integrated these into the Nix configuration using `mkOutOfStoreSymlink` for real-time updates.
- **Aesthetic Alignment**: 
    - Successfully implemented 80% window transparency and blur in Neovide to match the Ghostty/Neovim visual style.
    - Configured `vim.g.neovide_opacity` and `vim.g.neovide_normal_opacity` for consistent rendering across Neovide versions.
- **Troubleshooting & Fixes**:
    - Resolved TOML parsing errors by refining the `[font]` and `[[font.normal]]` structures.
    - Identified and diagnosed a `nixos-rebuild` hang caused by an automatic `flatpak update` command in the system activation scripts.

## Session 11: Matugen 4.0 Migration and Script Robustness
- **Matugen 4.0.0 Compatibility**:
    - Updated `config.toml` to the new `[config.wallpaper]` format, replacing `arguments` with a single `command` string using the `{{ image }}` placeholder.
    - Implemented `--source-color-index 0` across all `matugen` calls (wallpaper scripts, startup scripts) to ensure non-interactive execution and fix breaking changes.
    - Fixed a logic error in the `hyprland-colors.conf` template that caused `$image` to be redundantly generated inside a loop.
- **Nix-Wrapped Script Hardening**:
    - Enhanced `wallpaper.nix` and `rofi.nix` by adding `runtimeInputs` (including `glib`, `swaynotificationcenter`, `hyprland`, `procps`, etc.) to ensure all script dependencies and `post_hook` commands are available in the Nix store environment.
    - Added a `post_hook` to Matugen for SwayNC to trigger automatic CSS reloading via `swaync-client -rs`.
- **Neovim Workflow Optimization**:
    - Refined `project-explorer.nvim` to restrict project discovery to the top level of `~/dev/`, eliminating deep recursive searching.
    - Replaced the default Neo-tree integration with **Yazi** for a faster, CLI-native project browsing experience.

## Session 12: VS Code Integration, Shader Tuning, and Real-Time Theme Sync
- **VS Code Neovim**: Integrated the `asvetliakov.vscode-neovim` extension into the VS Code Home Manager module to provide a real Neovim instance as the editor backend.
- **Shader & Animation Tuning**:
    - Reverted Ghostty's `cursor_warp.glsl` to `EaseOutCirc` after testing spring-based easing to ensure consistent visibility.
    - Implemented mode-specific paste mappings (`Ctrl+v`) for Neovide to prevent literal text injection in Insert mode while maintaining system clipboard compatibility.
- **Automated Neovim Theming**:
    - **Matugen Template**: Created a new Matugen template to generate a Lua color palette at `~/.config/nvim/matugen.lua`.
    - **Instant Reload**: Implemented a `:MatugenReload` command in Neovim that hot-reloads colors and updates both syntax highlights and the Lualine theme without a restart.
    - **RPC Synchronization**: Added a backgrounded `post_hook` to Matugen that uses Neovim's RPC sockets (`nvim --server`) to automatically trigger a theme reload in all running instances whenever the wallpaper changes.
- **Terminal-Centric Workflow**:
    - Configured Neovide to act as a full-window terminal emulator using `<leader>t`.
    - Refined navigation keymaps (`Shift-h/l`) to only trigger buffer changes when in terminal Normal mode, preventing collisions with shell input.
    - Added autocommands to ensure terminal buffers automatically enter Insert mode and use a clean, numberless UI.

## Session 13: Rofi-Based Clipboard Manager with Granular Control
- **Wayland Clipboard Integration**:
    - Implemented a clipboard manager using `cliphist` (history) and `wl-clipboard` (Wayland clipboard utilities).
    - Integrated clipboard watchers into the Hyprland `start-up.sh` to automatically capture both text and images.
- **Rofi UI & Custom Theming**:
    - Created a dedicated Rofi theme (`clipboard.rasi`) with a single-column list layout and custom prompts.
    - Developed a Nix-wrapped `rofi-clipboard-sh` script that pipes `cliphist` output into Rofi and handles item selection.
- **Interactive Management (Sub-menus)**:
    - Designed an "Action Sub-menu" workflow to provide a visual, button-like interface for managing history.
    - Selecting an item opens a secondary menu with options: **Copy**, **Delete**, or **Cancel**.
    - Enabled continuous management: deleting an item returns the user to the refreshed clipboard list without closing the Rofi window.
- **Global Clipboard Wipe**:
    - Integrated a "󰃢 Clear All History" option at the top of the clipboard list.
    - Implemented a confirmation dialog (Yes/No) to prevent accidental wipes.
- **Technical Hardening & Fixes**:
    - Switched back to the unified `rofi` package after resolving a build error where `rofi-wayland` was found to be merged into the main package in `nixpkgs`.
    - Resolved keybinding conflicts by moving from keyboard-only shortcuts (`Alt+d`) to the more reliable sub-menu interaction model.

## Session 14: Cloud Storage Integration and Automated Mounting
- **Declarative Cloud Mounting**:
    - Implemented a Google Drive mount using **Rclone** and **FUSE**, managed via a new `modules/home/programs/cloud.nix` module.
- **Automated Mounting Service**:
    - Developed a **Systemd User Service** (`rclone-gdrive.service`) to automatically mount Google Drive to `~/Cloud/GoogleDrive` on login.
    - Optimized the mount with `--vfs-cache-mode full` and a 10GB local cache to ensure stability for Cryptomator and heavy file operations.
- **Security & Permissions**:
    - Enabled `programs.fuse.userAllowOther` globally in `modules/system/packages.nix`.
    - Resolved "Operation not permitted" errors by explicitly adding `/run/wrappers/bin` to the systemd service environment, ensuring access to the SUID `fusermount3` wrapper.
- **Cryptomator Integration**:
    - Integrated `cryptomator` into the Home Manager configuration to manage encrypted vaults directly on the mounted Google Drive.
- **System Cleanup**:
    - Deduplicated `rclone` from system-level packages, keeping it exclusively in the Home Manager module for better user isolation.

## Session 15: Legacy Shell Cleanup (DMS Removal)
- **Repository Optimization**: 
    - Removed the `dms` (Dank Material Shell) flake input and its associated `flake.lock` entries.
    - Deleted all legacy DMS configuration modules (`modules/home/desktop/dms/`) and dotfiles (`dot-files/dms/`).
    - Cleaned up imports in `home.nix` and `modules/home/desktop/default.nix` to finalize the migration to the custom "Meow" desktop environment.

