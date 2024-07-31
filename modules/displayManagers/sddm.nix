{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.displayManagers.sddm;
in {
  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}
