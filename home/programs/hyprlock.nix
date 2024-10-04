{ config, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = with config.colorScheme.palette; {
      general = {
        grace = 10;
      };
      background = {
        monitor = ""; # All monitors
	path = toString ../../wallpaper.png;
      };
    };
  };
}
