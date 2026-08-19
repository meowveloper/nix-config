{ pkgs, ... }:

{
    # Freedesktop Secret Service (org.freedesktop.secrets) via GNOME Keyring.
    # Needed so noctalia and other apps can store passwords/tokens.
    # NOTE: Unlock happens manually in dot-files/.../mango/start-up.sh because
    # login is via greetd/tuigreet (no PAM auto-unlock).
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
        gnome-keyring
        libsecret      # provides the `secret-tool` CLI to test the API
        seahorse       # GUI to view/edit keyring entries
        zenity         # GUI password prompt for manual keyring unlock
    ];
}