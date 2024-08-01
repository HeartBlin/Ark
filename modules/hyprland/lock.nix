{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;
in {
  config.home-manager.users."${user}" = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

      settings = {
        background = {
          path = "screenshot";
          blur_passes = 2;
          blur_size = 5;
          noise = 1.17e-2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        input-field = [{
          monitor = "eDP-1";
          size = "300, 50";
        }];
      };
    };
  };
}
