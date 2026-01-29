{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  zramSwap.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    kitty
    git
    firefox
  ];
}
