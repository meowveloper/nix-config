{
  description = "My Modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The Neovim Bridge
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = { nixpkgs, home-manager, nixCats, ... }@inputs: 
  let
    userSettings = import ./user-settings.nix;
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
      inherit system;
      # This passes variables to all NixOS modules (like configuration.nix)
      specialArgs = { inherit inputs userSettings; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # This passes variables to all Home Manager modules (like home.nix)
          home-manager.extraSpecialArgs = { inherit inputs userSettings; };
          
          home-manager.users.${userSettings.username1} = {
            imports = [ 
              ./home.nix 
              nixCats.homeModule
            ];
            home.username = userSettings.username1;
            home.homeDirectory = "/home/${userSettings.username1}";
          };

          home-manager.users.${userSettings.username2} = {
            imports = [ 
              ./home.nix 
              nixCats.homeModule
            ];
            home.username = userSettings.username2;
            home.homeDirectory = "/home/${userSettings.username2}";
          };
        }
      ];
    };
  };
}
