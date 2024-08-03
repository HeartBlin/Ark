{ config, inputs, lib, pkgs, ... }:

let hostName = config.Ark.hostName;
in {
  imports = [ inputs.chaotic.nixosModules.default ];

  boot = {
    "Skadi" = {
      initrd.systemd.enable = true;
      kernelPackages = pkgs.linuxPackages_cachyos-lto;
    };

    "Specter" = {
      initrd.systemd.enable = false;
      kernelPackages =
        config.boot.zfs.package.latestCompatibleLinuxPackages;
    };
  }."${hostName}";
}
