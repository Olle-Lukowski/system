{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  programs.wofi = {
    enable = true;

    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      term = "kitty";
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      columns = 2;
    };

    style = with config.colorScheme.palette; ''
      * {
        font-family: FiraCode Nerd Font;
	font-size: 15px;
      }

      window {
        background-color: #${base00};
	color: #${base05};
      }

      #entry:nth-child(odd) {
        background-color: #${base00};
      }

      #entry:nth-child(even) {
        background-color: #${base01};
      }

      #entry:selected {
        background-color: #${base02};
      }

      #input {
        background-color: #${base01};
	color: #${base04};
	border-color: #${base02};
      }

      #input:focus {
        border-color: #${base0A};
      }
    '';
  };
}
