{ inputs, ... }:

{
  imports =
    [ 
      inputs.dms.nixosModules.dank-material-shell
      ./hardware-configuration.nix
      ./modules/system/users.nix
      ./modules/system/boot.nix
      ./modules/system/network.nix
      ./modules/system/locale.nix
      ./modules/system/display.nix
      ./modules/system/hyprland.nix
      ./modules/system/dms.nix
      ./modules/system/nix-settings.nix
      ./modules/system/packages.nix
      ./modules/system/shell.nix
      ./modules/system/flatpak.nix
      ./modules/system/audio.nix
      ./modules/system/burmese.nix
    ];

  system.stateVersion = "25.11";
}
