{ pkgs, ... }: {
  # Hyprland Home Manager Module
  wayland.windowManager.hyprland.systemd.enable = false;


  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  xdg.configFile."hypr/src".source = ../../../dot-files/.config/hypr/src;
  xdg.configFile."hypr/dms/binds.conf".source = ../../../dot-files/.config/hypr/dms/binds.conf;
  xdg.configFile."hypr/dms/cursor.conf".source = ../../../dot-files/.config/hypr/dms/cursor.conf;
  xdg.configFile."hypr/dms/dank.conf".source = ../../../dot-files/.config/hypr/dms/dank.conf;
  xdg.configFile."hypr/dms/layout.conf".source = ../../../dot-files/.config/hypr/dms/layout.conf;
  xdg.configFile."hypr/dms/outputs.conf".source = ../../../dot-files/.config/hypr/dms/outputs.conf;
  xdg.configFile."hypr/hyprland.conf".source = ../../../dot-files/.config/hypr/hyprland.conf; 
  
  # Replacement for the old start-up.sh
  xdg.configFile."hypr/start-up.sh".text = ''
    #!/usr/bin/env bash
    # Nix-managed startup script

    # make sure dms colors are available
    touch ~/.config/hypr/dms/colors.conf

    # DBus environment
    dbus-update-activation-environment --systemd --all

    # start dms
    dms run &

    # create user specific zsh file
    touch ~/.config/zsh-config/user

    # Polkit Agent (Nix path)
    ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &

    # Input Method
    fcitx5 -d --replace

    # reload
    hyprctl reload
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
