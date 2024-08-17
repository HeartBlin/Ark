_: {
  config = {
    Ark = {
      asus.enable = true;
      flakeDir = "/home/heartblin/Ark";
      gaming.enable = true;
      nvidia = {
        enable = true;
        hybrid = {
          enable = true;
          id = {
            amd = "PCI:6:0:0";
            nvidia = "PCI:1:0:0";
          };
        };
      };
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Bucharest";

    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}

