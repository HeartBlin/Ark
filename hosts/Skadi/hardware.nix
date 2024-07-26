{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/56d8916e-1c3c-4abc-95ee-23bc7b6679d6";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  boot.initrd.luks.devices."enc".device =
    "/dev/disk/by-uuid/12be92c3-3609-451e-908a-99a2da020c54";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/56d8916e-1c3c-4abc-95ee-23bc7b6679d6";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/56d8916e-1c3c-4abc-95ee-23bc7b6679d6";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5686-2703";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/48850e12-b89d-4aae-8d2b-1e76a139019d"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
