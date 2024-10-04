{ config, lib, ... }:

{
  imports = [
    ./kitty.nix
    ./wofi.nix
  ];

  options.hyprland = {
    monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
	options = {
	  name = lib.mkOption {
	    type = lib.types.str;
            description = "The name of the monitor (to check, run: hyprctl monitors)";
	    example = "DP-1";
	  };
	  width = lib.mkOption {
	    type = lib.types.int;
	    description = "The width for the monitor's resolution (default is 1920)";
	    default = 1920;
	    example = 2560;
	  };
          height = lib.mkOption {
	    type = lib.types.int;
	    description = "The height for the monitor's resolution (default is 1080)";
	    default = 1080;
            example = 1440;
	  };
	  refreshRate = lib.mkOption {
	    type = lib.types.int;
	    description = "The refresh rate of the monitor (default is 60 Hz)";
	    default = 60;
	    example = 144;
	  };
	  xPosition = lib.mkOption {
	    type = lib.types.int;
	    description = "The x position of the monitor (default is 0)";
	    default = 0;
	    example = 1920;
	  };
	  yPosition = lib.mkOption {
	    type = lib.types.int;
            description = "The y position of the monitor (default is 0)";
	    default = 0;
	    example = 1080;
	  };
	  scale = lib.mkOption {
	    type = lib.types.float;
	    description = "The display scale of the monitor (default is 1)";
	    default = 1;
            example = 1.5;
	  };
	};
      });
      description = "List of monitor configurations, each with a name, width, height, refresh rate, x position, y position, and scale";
      default = [ ];
      example = [
        {
	  name = "DP-1";
	  width = 1920;
	  height = 1080;
	  refreshRate = 144;
	  xPosition = 0;
	  yPosition = 0;
	  scale = 1;
	}
      ];
    };
  };

  config = {

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "ALT";

        bind = [
          # Terminal keybind
          "$mod, T, exec, kitty"

          # Mod + Shift + Q to kill window
          "$mod SHIFT, Q, killactive"

          # App Runner
          "$mod, R, exec, wofi"

          # Move focus
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod, Left, movefocus, l"
          "$mod, Down, movefocus, d"
          "$mod, Up, movefocus, u"
          "$mod, Right, movefocus, r"

          # Move window
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, Left, movewindow, l"
          "$mod SHIFT, Down, movewindow, d"
          "$mod SHIFT, Up, movewindow, u"
          "$mod SHIFT, Right, movewindow, r"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        general = with config.colorScheme.palette; {
      	  border_size = 3;

          resize_on_border = true;

      	  "col.active_border" = "rgba(${base0E}ff) rgba(${base09}ff) 60deg";
          "col.inactive_border" = "rgba(${base00}ff)";
        };

        decoration = with config.colorScheme.palette; {
          rounding = 7;
          active_opacity = 0.9;
          inactive_opacity = 0.5;
        
          shadow_range = 10;
        
          "col.shadow" = "rgba(${base01}ff)";
          "col.shadow_inactive" = "rgba(${base02}ff)";
        };

	monitor = map (monitor: "${monitor.name}, ${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate}, ${toString monitor.xPosition}x${toString monitor.yPosition}, ${toString monitor.scale}") config.hyprland.monitors ++ [
	  ", preferred, auto, 1" # Catch-all
	];
      };
    };
  };
}
