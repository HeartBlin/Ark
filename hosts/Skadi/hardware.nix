{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c0a2ba8a-0730-4bfd-ad8f-86554ca0bc5c";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  boot.initrd.luks.devices."encrypted".device =
    "/dev/disk/by-uuid/f06e6be5-394e-4541-9b9b-5a1f331428f3";

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/c0a2ba8a-0730-4bfd-ad8f-86554ca0bc5c";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/c0a2ba8a-0730-4bfd-ad8f-86554ca0bc5c";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c0a2ba8a-0730-4bfd-ad8f-86554ca0bc5c";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/271C-9693";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices =
    [{ device = "/swap/swapfile"; }];
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
