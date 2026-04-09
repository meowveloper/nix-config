#!/usr/bin/env bash
dbus-update-activation-environment --systemd --all
mkdir -p ~/.cache
mkdir -p ~/.config/ghostty/themes
touch ~/.config/zsh-config/user

# Just use the name; Nix will find the path for you
polkit-kde-authentication-agent-1 & 
fcitx5 -d --replace

waybar &
swww-daemon &
swaync &

# Clipboard Manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

if [[ -f ~/.cache/last-wallpaper ]]; then
  matugen image ~/.cache/last-wallpaper --source-color-index 0
else
  matugen image ~/.config/wallpapers/default.jpg --source-color-index 0
fi
