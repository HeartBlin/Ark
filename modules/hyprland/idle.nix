{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  rB = pkgs.writeShellScript "brightness" (builtins.readFile ./brightness);

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
            timeout = 180;
            on-timeout = "${rB.outPath} set 10 0";
            on-resume = "${rB.outPath} restore";
          }
          {
            timeout = 210;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 240;
            on-timeout = "hyprctl keyword monitor HDMI-A-1,disable";
            on-resume = "hyprctl reload";
          }
          {
            timeout = 240;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 300;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
