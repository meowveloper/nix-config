{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Hint Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # XDG Portals are required for many things (screen sharing, file picking, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk 
    ];
  };
}
