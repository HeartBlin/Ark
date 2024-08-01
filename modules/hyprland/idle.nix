{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;
in {
  config.home-manager.users."${user}" = mkIf cfg.enable {
    home.packages = [ pkgs.brightnessctl ];

    wayland.windowManager.hyprland.settings.windowrulev2 =
      [ "idleinhibit always, fullscreen:1" ];

    services.hypridle = {
      enable = true;
      package = inputs.hypridle.packages.${pkgs.system}.hypridle;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "logictl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 60;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 60;
            on-timeout = "brightnessctl -sd *::kbd_backlight set 0";
            on-resume = "brightnessctl -rd *::kbd_backlight";
          }
          {
            timeout = 120;
            on-timeout = "pidof hyprlock || hyprlock";
          }
          {
            timeout = 180;
            on-timeout = "hyprctl keyword monitor HDMI-A-1,disable";
            on-resume = "hyprctl reload";
          }
          {
            timeout = 180;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 240;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
