#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1

dbus-update-activation-environment --systemd --all

mkdir -p ~/.cache
mkdir -p ~/.config/ghostty/themes
touch ~/.config/zsh-config/user

polkit-kde-authentication-agent-1 &
fcitx5 -d --replace

nm-applet &
wlsunset &
noctalia &

# Clipboard Manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

