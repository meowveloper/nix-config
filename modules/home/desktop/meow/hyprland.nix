{ pkgs, ... }: {

  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  xdg.configFile."hypr/src".source = ../../../dot-files/.config/hypr/src;
  xdg.configFile."hypr/dms/binds.conf".source = ../../../dot-files/.config/hypr/dms/binds.conf;
  xdg.configFile."hypr/dms/cursor.conf".source = ../../../dot-files/.config/hypr/dms/cursor.conf;
  xdg.configFile."hypr/dms/dank.conf".source = ../../../dot-files/.config/hypr/dms/dank.conf;
  xdg.configFile."hypr/dms/layout.conf".source = ../../../dot-files/.config/hypr/dms/layout.conf;
  xdg.configFile."hypr/dms/outputs.conf".source = ../../../dot-files/.config/hypr/dms/outputs.conf;
  xdg.configFile."hypr/hyprland.conf".source = ../../../dot-files/.config/hypr/hyprland.conf; 
  
  xdg.configFile."hypr/start-up.sh".text = ''
    #!/usr/bin/env bash

    dbus-update-activation-environment --systemd --all

    # create cache folder
    mkdir -p ~/.cache

    # create user specific zsh file
    touch ~/.config/zsh-config/user

    # Polkit Agent (Nix path)
    ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &

    # Input Method
    fcitx5 -d --replace

    swww-daemon &
    # matugen
    if [[ -f ~/.cache/last-wallpaper ]]; then
      matugen image ~/.cache/last-wallpaper
    else
      matugen image ~/.config/wallpapers/wallhaven-xld2k3.jpg
    fi
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
