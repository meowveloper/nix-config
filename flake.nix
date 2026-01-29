{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let
    userSettings = import ./user-settings.nix;
  in
  {
    nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
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