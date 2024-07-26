{ config, lib, pkgs, ... }:

{
  config = {
    Ark = {
      hardware = {
        cpu = { };
        gpu = {
          hybrid = true;
          type = "nvidia";
          ids = {
            amd = "PCI:6:0:0";
            nvidia = "PCI:1:0:0";
          };
        };
      };
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users.heartblin = { packages = with pkgs; [ vscode git firefox ]; };
  };
}
