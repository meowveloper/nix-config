#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland

dbus-update-activation-environment --systemd --all
systemctl --user restart dms.service

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

