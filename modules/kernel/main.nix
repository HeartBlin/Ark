{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkForce;

  hostName = config.Ark.hostName;
in {
  imports = [ inputs.chaotic.nixosModules.default ];

  boot.kernelPackages = {
    "Specter" = config.boot.zfs.package.latestCompatibleLinuxPackages;
    "Skadi" = pkgs.linuxPackages_cachyos-lto;
  }."${hostName}";

  boot.initrd.systemd.enable = mkForce true;
}
