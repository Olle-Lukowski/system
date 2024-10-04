{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      # TODO: Remove hardcoded reference to hyprland, make it configurable
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    # Prevent error spam
    StandardError = "journal";
    # Prevent bootlog spam
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
