{ ... }: {
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  zramSwap = {
    enable = true;
    priority = 100;     
    algorithm = "zstd";     
    memoryPercent = 200;
  };

}
