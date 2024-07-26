{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.gnome;
in {
  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
