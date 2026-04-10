{ pkgs, ... }: {
  programs.niri = {
    enable = true;
  };

  # Ensure Niri related environment variables are set
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    # Force Qt apps to use Wayland, but fallback to xcb if needed
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  # Portal configuration for Niri
  xdg.portal = {
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config.niri.default = [ "gnome" "gtk" ];
  };
}
