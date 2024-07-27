{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;

  wallpaper = config.Ark.home.hyprland.wallpaper;

  refresh = pkgs.writeShellScriptBin "refresh" ''
    handle() {
      case $1 in
        monitoradded*) hyprctl reload;;
      esac
    }

    socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
  '';

  firstWallpaper = config.Ark.home.hyprland.wallpapers.firstWallpaper;
  secondWallpaper = config.Ark.home.hyprland.wallpapers.secondWallpaper;
in {
  config.home-manager.users."${user}" = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings =
      if !config.Ark.home.hyprland.wallpapers.isTwo then {
        exec-once = [ "swww-daemon --no-cache" ];
        exec = [
          "swww img ${wallpaper} -t wipe --transition-angle 30 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
        ];
      } else {
        exec-once = [ "swww-daemon --no-cache" "${refresh.outPath}/bin/refresh"];
        exec = [
          "swww img ${firstWallpaper} -o eDP-1 -t wipe --transition-angle 30 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
          "swww img ${secondWallpaper} -o HDMI-A-1 -t wipe --transition-angle 120 --transition-step 255 --transition-fps 144 --transition-duration 1.2"
        ];
      };

    home.packages = [ pkgs.swww refresh pkgs.socat ];
  };
}
