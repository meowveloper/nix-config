#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=mango
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH"

dbus-update-activation-environment --systemd --all

# xdg-desktop-portal-wlr may have skipped startup because WAYLAND_DISPLAY
# wasn't in systemd --user env yet when graphical-session.target activated.
# Now that the compositor is up, import the env and restart the portals.
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user restart xdg-desktop-portal-wlr.service xdg-desktop-portal.service || true

mkdir -p ~/.cache
mkdir -p ~/.config/ghostty/themes
touch ~/.config/zsh-config/user

polkit-kde-authentication-agent-1 &
fcitx5 -d --replace

wlsunset &

# --- Secret Service (GNOME Keyring) ---
# greetd/tuigreet login does not use PAM, so the keyring isn't unlocked
# automatically. Start the daemon, then unlock the default keyring manually.
eval "$(gnome-keyring-daemon --start --components=secrets)"
if ! secret-tool lookup keyring initialized >/dev/null 2>&1; then
    KEYRING_PW=$(zenity --password --title="Unlock GNOME Keyring" 2>/dev/null || true)
    if [ -n "$KEYRING_PW" ]; then
        printf '%s' "$KEYRING_PW" | gnome-keyring-daemon --unlock
        unset KEYRING_PW
    fi
fi
secret-tool store --label="session-init" session initialized "true" >/dev/null 2>&1 || true

noctalia &

# Clipboard Manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

