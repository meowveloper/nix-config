#!/usr/bin/env bash
dbus-update-activation-environment --systemd --all
mkdir -p ~/.cache
mkdir -p ~/.config/ghostty/themes
touch ~/.config/zsh-config/user

# Just use the name; Nix will find the path for you
polkit-kde-authentication-agent-1 & 
fcitx5 -d --replace
swww-daemon &
swaync &

if [[ -f ~/.cache/last-wallpaper ]]; then
  matugen image ~/.cache/last-wallpaper
else
  matugen image ~/.config/wallpapers/wallhaven-xld2k3.jpg
fi
