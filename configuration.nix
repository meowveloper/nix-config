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
      ./modules/system/bluetooth.nix
      ./modules/system/direnv.nix
    ];

  system.stateVersion = "25.11";
  fileSystems."/mnt/extra-volume" = {    
    device = "/dev/disk/by-uuid/1ed14588-7c5b-4f65-98cc-0f3a746ea157";
    fsType = "ext4";            
    options = [ "defaults" "user" "exec" "nofail" ]; 
  };
}
