{ inputs, ... }: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    ./modules/home/default.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
