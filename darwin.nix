{ pkgs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  programs.bash.enable = true;

  services.nix-daemon.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.knownUsers = [ "olle" ];
  users.users.olle = {
    name = "olle";
    home = "/Users/olle";
    shell = pkgs.bash;
    uid = 501;
  };

  system.stateVersion = 5;
}
