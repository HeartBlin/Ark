{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;
in {
  config.home-manager.users."${user}" = mkIf cfg.enable {
    imports = [ inputs.ags.homeManagerModules.default ];
    programs.ags = {
      enable = true;
      configDir = ./ags;
    };

    home.packages = [ pkgs.bun pkgs.hyprpicker pkgs.sassc ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [ "ags" ];
      blurls = [ "agsbar-0" "agsbar-1" ];
    };
  };
}
