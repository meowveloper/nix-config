# ❄️ Deterministic NixOS Configuration

A fully declarative, Flake-based NixOS configuration designed for high-performance development and a streamlined TUI-driven workflow.

## 🚀 Key Features
* **Modern Nix:** Leverages **Nix Flakes** for hermetic, reproducible system builds.
* **Performance-First:** Minimalist environment using **Hyprland** (Wayland) to maximize system resources for heavy development tasks.
* **Declarative Tooling:** Comprehensive management of TUIs (**lazygit**, **yazi**, **rmpc**) and **Flatpaks** via specialized Nix modules.
* **Developer Experience:** Optimized for low-latency workflows, bypassing heavy desktop managers for a direct TTY-to-Session login.

## 🛠 Technical Architecture
* **System:** NixOS (Unstable/Stable mix via Flakes)
* **WM:** Hyprland
* **Dotfiles:** Managed via **Home Manager**
* **Modularity:** Separated `user-settings.nix` and hardware configurations for easy portability across machines.

## 💻 Usage & Reproduction
1. **Clone:** `git clone https://github.com/meowveloper/nix-config.git`
2. **Configure:** Modify `user-settings.nix` for your specific user/git credentials and update the hardware symlink.
3. **Apply:** ```bash
   sudo nixos-rebuild switch --flake .#your-hostname
    ```
