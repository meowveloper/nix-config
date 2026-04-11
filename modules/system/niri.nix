{ pkgs, ... }: {
  programs.niri = {
    enable = true;
  };

  # Ensure Niri related environment variables are set
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
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
