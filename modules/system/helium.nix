{ inputs, ... }: {
  imports = [ inputs.helium.nixosModules.default ];

  programs.helium = {
    enable = true;
    flags = [
      "--password-store=basic"
      "--ozone-platform-hint=auto"
    ];
  };
}
