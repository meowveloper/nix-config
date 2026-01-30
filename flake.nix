{
  description = "My Modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
  let
    userSettings = import ./user-settings.nix;
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs userSettings; };
      modules = [
        ./configuration.nix

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
