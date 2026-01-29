{ ... }: {
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.hyprland.enable = true;
}
