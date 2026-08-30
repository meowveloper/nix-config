{
  description = "My Modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    meowmux = {
      url = "github:meowveloper/meowmux?ref=v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    meowkey = {
      url = "github:meowveloper/meowkey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    bunnix = {
      url = "github:aster-void/bunnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, mangowm, nix-flatpak, bunnix, ... }@inputs:
  let
    userSettings = import ./user-settings.nix;
    machineSettings = import ./machine-settings.nix;
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs userSettings machineSettings; };
      modules = [
        { nixpkgs.hostPlatform = system; }

        # Pin xdg-desktop-portal-wlr to 0.8.2 — v0.8.3 has a known
        # freeze bug where screensharing stalls after the first frame.
        # https://github.com/NixOS/nixpkgs/issues/546183
        { nixpkgs.overlays = [
          (final: prev: {
            xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (old: {
              version = "0.8.2";
              src = prev.fetchFromGitHub {
                owner = "emersion";
                repo = "xdg-desktop-portal-wlr";
                rev = "v0.8.2";
                hash = "sha256-HITf/hgiASWvn/z49mzS8IS1vuyXwdk1JiAOOHRSQMo=";
              };
            });
          })

          # Use bunnix to always get the latest bun release
          (_final: prev: {
            bun = inputs.bunnix.packages.${prev.stdenv.hostPlatform.system}.latest;
          })
        ]; }

        ./configuration.nix

        mangowm.nixosModules.mango
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs userSettings; };
          home-manager.backupFileExtension = "backup";
          home-manager.users.${userSettings.username1} = {
            imports = [ ./home.nix ];
            home.username = userSettings.username1;
            home.homeDirectory = "/home/${userSettings.username1}";
          };

          home-manager.users.${userSettings.username2} = {
            imports = [ ./home.nix ];
            home.username = userSettings.username2;
            home.homeDirectory = "/home/${userSettings.username2}";
          };
        }
      ];
    };
  };
}
