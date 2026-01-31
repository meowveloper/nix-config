{ pkgs, config, ... }: {
  # Hyprland Home Manager Module
  wayland.windowManager.hyprland = {
    enable = true;
    # We point to your specific config file
    extraConfig = builtins.readFile ../../../dot-files/.config/hypr/hyprland.conf;
  };

  # XDG User Directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
    };
  };

  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  xdg.configFile."hypr/src".source = ../../../dot-files/.config/hypr/src;
  xdg.configFile."hypr/dms".source = ../../../dot-files/.config/hypr/dms;
  
  # Replacement for the old start-up.sh
  xdg.configFile."hypr/start-up.sh".text = ''
    #!/usr/bin/env bash
    # Nix-managed startup script

    # 1. DBus environment
    dbus-update-activation-environment --systemd --all

    # create user specific zsh file
    touch ~/.config/zsh-config/user

    # 2. Polkit Agent (Nix path)
    ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &

    # 3. Input Method
    fcitx5 -d --replace
  '';
  xdg.configFile."hypr/start-up.sh".executable = true;

  xdg.configFile."ghostty/config".source = ../../../dot-files/.config/ghostty/config;

  # Supporting packages for your Hyprland setup
  home.packages = with pkgs; [
    ghostty
    kdePackages.polkit-kde-agent-1
    hyprshot
    grim
    slurp
    libnotify
  ];
}
