{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;

  cursorName = config.Ark.home.hyprland.cursor.name;
  cursorPackage = config.Ark.home.hyprland.cursor.package;
  cursorSize = config.Ark.home.hyprland.cursor.size;

  cursorSizeString = builtins.toString cursorSize;
in {
  config.home-manager.users."${user}" = mkIf cfg.enable {
    home.pointerCursor = {
      package = cursorPackage;
      name = "${cursorName}";
      size = cursorSize;
      gtk.enable = true;
      x11.enable = true;
    };

    wayland.windowManager.hyprland.settings.env =
      [ "XCURSOR_THEME=${cursorName}" "XCURSOR_SIZE=${cursorSizeString}" ];
  };
}
