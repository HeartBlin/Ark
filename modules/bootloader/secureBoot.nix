{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkForce mkIf;

  cfg = config.Ark.secureBoot;
in {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.sbctl ];
    boot.loader.systemd-boot.enable = mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
