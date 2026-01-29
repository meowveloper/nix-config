# Gemini CLI Workspace Instructions

This file tracks the project standards and key Nix concepts for our collaboration.

## 📝 Working with the Conversation Log
- **`conversation-log.md`**: This file is a manual record of our sessions. 
- **Rule**: I will only update the log when you explicitly ask me to.

## ❄️ Nix Ecosystem Concepts

### Home Manager
**Home Manager** is a tool used to manage your user-specific configuration (like dotfiles, user packages, and shell aliases) using the Nix language. While NixOS handles the "system" (drivers, hardware, global services), Home Manager handles "you" (your terminal, your editor, your desktop theme).

### NixOS (The OS)
The base operating system where the entire system state is defined in a single configuration file (`configuration.nix`). If it's not in the config, it doesn't exist on the system.

### The Nix Store vs. Home Directory
- **The Store (`/nix/store`)**: Read-only. This is where Nix keeps "perfect" versions of software.
- **Home Directory (`~`)**: Writable. Your apps (like Neovim) can still create logs, download plugins, and save files here.

### Nix Flakes
A **Flake** is a standard way to define a Nix project. It uses a `flake.nix` file to list inputs (dependencies like `nixpkgs`) and outputs (your system config).
- **`flake.lock`**: This file "pins" your dependencies to exact versions. If you share your config, anyone else will get the exact same system you have.

### Deduplication
If multiple users (or the system) install the exact same version of a package, Nix only stores **one copy** in `/nix/store`. This makes multi-user setups extremely disk-efficient.

### Nix Function Syntax (`{ pkgs, ... }:`)
Almost every Nix file is a **function**. 
- **`{ pkgs, ... }`**: These are the inputs. `pkgs` is the package library. The `...` allows other inputs (like `userSettings`) to be passed without causing errors.
- **`:`**: Marks the start of the configuration block.
- **Where do inputs come from?**: They are "injected" by your `flake.nix`. This is why we used `specialArgs`—to inject your private usernames into every file.
