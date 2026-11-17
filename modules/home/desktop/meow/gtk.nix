{ pkgs, ... }: {
    # GTK theme packages are kept so GTK apps and theme pickers can use them.
    # Theme selection is left to the desktop (COSMIC has no GTK-style page, so
    # GTK apps fall back to their defaults) instead of home-manager's gtk
    # module, which would pin ~/.config/gtk-3.0/settings.ini.
    home.packages = with pkgs; [
        adw-gtk3
        papirus-icon-theme
    ];
}
