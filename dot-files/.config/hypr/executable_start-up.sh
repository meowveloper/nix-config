#!/usr/bin/env bash

# 1. DBus environment (must stay first)
dbus-update-activation-environment --systemd --all

# 2. Create required directories and files
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/.rmpc-cache
mkdir -p ~/.config/matugen-outs
mkdir -p ~/.cache
touch ~/.config/hypr/src/user-specific.conf
touch ~/.config/shell/user

# start services
systemctl --user enable --now mpd.service
dms run &
bash /usr/lib/polkit-kde-authentication-agent-1

fcitx5 --replace -d




