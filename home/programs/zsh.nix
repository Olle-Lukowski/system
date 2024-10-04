{ pkgs, ... }:

{
  imports = [
    ./eza.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    git
  ];

  programs.zsh = {
	  enable = true;

		autocd = true;

		shellAliases = {
			ls = "eza";
			ll = "ls -l";
      la = "ls -la";
		};

    zplug = {
      enable = true;

      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "fdellwing/zsh-bat"; }
      ];
    };
	};
}
