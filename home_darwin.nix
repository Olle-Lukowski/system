{ inputs, config, ... }:

{
  home.username = "olle";
  home.homeDirectory = "/Users/olle";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.mac-app-util.homeManagerModules.default
    ./home/programs/kitty.nix
    ./home/programs/neovim.nix
    ./home/programs/starship.nix
    ./home/programs/fzf.nix
    ./home/programs/zoxide.nix
    ./home/programs/bottom.nix
    ./home/programs/bash.nix
    ./home/programs/bacon.nix
    ./home/programs/vesktop.nix
    ./home/programs/zathura.nix
    ./home/programs/helix.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home.sessionVariables = {
    DBUS_SESSION_BUS_ADDRESS = "unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET";
  };
}
