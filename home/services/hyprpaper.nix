{ ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        (toString ../../wallpaper.png)
      ];

      wallpaper = [
        ",${toString ../../wallpaper.png}"
      ];
    };
  };
}
