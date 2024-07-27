{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.displayManagers.gdm;
in {
  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    security.pam.services.gdm.enableGnomeKeyring = true;
  };
}
