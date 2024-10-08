{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.vmware;
in {
  config = mkIf cfg.enable {
    virtualisation.vmware.host = {
      enable = true;
      package = pkgs.vmware-workstation;
    };
  };
}
