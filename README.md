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

## user settings format (`user-settings.nix`)
```nix
{
    username1 = "user-1"; # Change this to your real primary user
    username2 = "user-2";       # Change this to your secondary user
    dotfiles_path = "/path/to/dotfiles/in/nix-config/directory";
}
```

## how to run rebuild command when absolute path
> so that user-settings.nix get read when rebuilding

```bash
sudo nixos-rebuild switch --flake "path:/absolute/path/to/nix-config"
```
or

```bash
sudo nixos-rebuild switch --flake "path:/absolute/path/to/nix-config#your-hostname"
```

## 💻 Usage & Reproduction
1. **Clone:** `git clone https://github.com/meowveloper/nix-config.git`
2. **Configure:** Modify `user-settings.nix` for your specific user/git credentials and update the hardware symlink.
3. **Apply:**

    ```bash
    sudo nixos-rebuild switch --flake .#your-hostname
    ```
