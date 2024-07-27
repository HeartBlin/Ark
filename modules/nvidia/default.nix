{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkIf;

  cfg = config.Ark.hardware.gpu;
in {
  config = mkIf (cfg.type == "nvidia") {
    nixpkgs.config = {
      allowUnfree = true; # NVidia drivers are unfree
      nvidia.acceptLicense = true; # And they have a license
      cudaSupport = true; # Might as well use it
    };

    # Register it as a driver
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    # Set the kernel up a bit
    boot.blacklistedKernelModules = [ "noveau" ];
    boot.kernelParams = [
      "NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
    ];

    # Make things work
    environment.systemPackages = [
      pkgs.btop

      pkgs.vulkan-tools
      pkgs.vulkan-loader
      pkgs.vulkan-validation-layers
      pkgs.vulkan-extension-layer

      pkgs.libva
      pkgs.libva-utils
    ];

    hardware.nvidia = {
      # Always use latest
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      dynamicBoost.enable = mkDefault true;
      modesetting.enable = mkDefault true;

      prime = {
        reverseSync.enable = cfg.hybrid;

        amdgpuBusId = "${cfg.ids.amd}";
        intelBusId = "${cfg.ids.intel}";
        nvidiaBusId = "${cfg.ids.nvidia}";
      };

      powerManagement = {
        enable = mkDefault true;
        # Does not work if on true, TODO come back later
        finegrained = mkDefault false;
      };

      nvidiaSettings = false;
      open = mkDefault false; # open if >= 560
      nvidiaPersistenced = false;
      forceFullCompositionPipeline = true;
    };

    # Feed it vaapi
    hardware.graphics = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    };
  };
}
