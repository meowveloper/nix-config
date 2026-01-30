{ pkgs, ... }: {
  services.flatpak.enable = true;

  # This is important for Flatpaks to find system fonts
  fonts.fontDir.enable = true;

  # Ensure XDG portals are well configured (required for Flatpak)
  # We already have this in hyprland.nix, but it doesn't hurt to be sure.
  xdg.portal.enable = true;

  # Automatically add Flathub repository
  system.activationScripts.flatpak-flathub = {
    text = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
