{ inputs, ... }:

{
  home.username = "olle";
  home.homeDirectory = "/home/olle";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./home/programs/kitty.nix
    ./home/programs/firefox.nix
    ./home/programs/hyprland.nix
    ./home/programs/wofi.nix
    ./home/programs/hyprlock.nix
    ./home/programs/neovim.nix
    ./home/programs/zsh.nix
    ./home/programs/starship.nix
    ./home/programs/fzf.nix
    ./home/programs/zoxide.nix
    ./home/programs/bottom.nix
    ./home/services/hypridle.nix
    ./home/services/hyprpaper.nix
    ./home/services/mako.nix
  ];

  hyprland.monitors = [
    {
      name = "DP-2";
      width = 1920;
      height = 1080;
      refreshRate = 144;
      xPosition = 0;
      yPosition = 0;
      scale = 1.0;
    }
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
}
