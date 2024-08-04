{ config, inputs, pkgs, ... }:

let hostName = config.Ark.hostName;
in {
  imports = [ inputs.chaotic.nixosModules.default ];

  boot = {
    "Skadi" = {
      initrd.systemd.enable = true;
      kernelPackages = pkgs.linuxPackages_zen;
      kernel.sysctl = {
        "kernel.nmi_watchdog" = 0;
        "vm.compaction_proactiveness" = 0;
        "vm.watermark_boost_factor" = 0;
      };
    };

    "Specter" = {
      initrd.systemd.enable = false;
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    };
  }."${hostName}";

  zramSwap = {
    "Skadi" = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
    };

    "Specter".enable = false;
  }."${hostName}";
}
