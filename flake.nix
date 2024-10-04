{
  description = "My System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... } @ inputs: { 
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./system-config.nix
      ];
    };
        
    homeConfigurations."olle@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = let system = "x86_64-linux"; in (import nixpkgs { inherit system; });
      extraSpecialArgs = { inherit inputs; };

      modules = [ ./home.nix ];
    };
  };
}
