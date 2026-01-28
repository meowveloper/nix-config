{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		home-manager = {
			url = "github:nix-comminity/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }: {
		nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [./configuration.nix];
		};
		homeConfigurations.test = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages."x86_64-linux";
			modules = [./home.nix];
		}
	};
}
