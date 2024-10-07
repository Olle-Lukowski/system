{
  description = "My System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin.url = "github:lnl7/nix-darwin";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = { nixpkgs, home-manager, flake-utils, darwin, mac-app-util, ... } @ inputs: { 
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

    homeConfigurations."olle" = home-manager.lib.homeManagerConfiguration {
      pkgs = let system = "aarch64-darwin"; in (import nixpkgs { inherit system; });
      extraSpecialArgs = { inherit inputs; };

      modules = [ ./home_darwin.nix ];
    };

    darwinConfigurations."Olles-MacBook-Air" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        mac-app-util.darwinModules.default
        ./darwin.nix
      ];
    };
  };
}
