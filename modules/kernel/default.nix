{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkForce mkIf;
  hostName = config.Ark.hostName;
in {
  imports = [ inputs.chaotic.nixosModules.default ];

  boot.kernelPackages = {
    # Surprise tool that will help us later
    # "Specter" = pkgs.linuxPackages_latest;
    "Skadi" = pkgs.linuxPackages_cachyos;
  }."${hostName}";

  # For some reason with this enabled it waits for
  # a device which does not exist
  # TODO look into wtf this tries to do
  boot.initrd.systemd.enable = mkForce false;
}
