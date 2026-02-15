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
polkit-kde-authentication-agent-1 & 

# Input Method
fcitx5 -d --replace

# reload
hyprctl reload
