{ pkgs, config, ... }: {
  # Hyprland Home Manager Module
  wayland.windowManager.hyprland.systemd.enable = false;

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
  xdg.configFile."hypr/hyprland.conf".source = ../../../dot-files/.config/hypr/hyprland.conf; 
  
  # Replacement for the old start-up.sh
  xdg.configFile."hypr/start-up.sh".text = ''
    #!/usr/bin/env bash
    # Nix-managed startup script

    # 1. DBus environment
    dbus-update-activation-environment --systemd --all

    # 2. start dms
    dms run &

    # 3. create user specific zsh file
    touch ~/.config/zsh-config/user

    # 4. Polkit Agent (Nix path)
    ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &

    # 5. Input Method
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
