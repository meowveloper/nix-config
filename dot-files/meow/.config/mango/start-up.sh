#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland

dbus-update-activation-environment --systemd --all


mkdir -p ~/.cache
mkdir -p ~/.config/ghostty/themes
touch ~/.config/zsh-config/user

polkit-kde-authentication-agent-1 &
fcitx5 -d --replace

nm-applet &
wlsunset &

# Clipboard Manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

if [[ -f ~/.cache/last-wallpaper ]]; then
  matugen image ~/.cache/last-wallpaper --source-color-index 0
else
  matugen image ~/.config/wallpapers/default.jpg --source-color-index 0
fi

mmsg -l "S"
