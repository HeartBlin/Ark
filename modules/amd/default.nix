{ config, lib, ... }:

# Thanks to the peeps nixos-hardware
# https://github.com/NixOS/nixos-hardware
# Cheers!

let
  inherit (lib) mkIf;

  kver = config.boot.kernelPackages.kernel.version;
  cfg = config.Ark.hardware.cpu;
in {
  config = mkIf (cfg.type == "amd") {
    hardware.cpu.amd.updateMicrocode = true;

    boot = lib.mkMerge [
      (lib.mkIf
        ((lib.versionAtLeast kver "5.17") && (lib.versionOlder kver "6.1")) {
          kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
          kernelModules = [ "amd-pstate" ];
        })
      (lib.mkIf
        ((lib.versionAtLeast kver "6.1") && (lib.versionOlder kver "6.3")) {
          kernelParams = [ "amd_pstate=passive" ];
        })
      (lib.mkIf (lib.versionAtLeast kver "6.3") {
        kernelParams = [ "amd_pstate=active" ];
      })
    ];
  };
}
