{ pkgs, ... }:

{
  imports = [
    ./eza.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    git
  ];

  programs.bash = {
	  enable = true;

		shellAliases = {
			ls = "eza";
			ll = "ls -l";
      la = "ls -la";
		};
  };
}
