{ config, lib, pkgs, ... }:

{
  config = {
    Ark = {
      flakeDir = "/home/heartblin/Documents/Ark";
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

      home = {
        git = {
          user = "HeartBlin";
          email = "Manea.Emil@proton.me"; # Doxxed lel
          signKey = "~/.ssh/GithubSign.pub";
        };

        steam.enable = true;
      };
    };

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    users.users.heartblin = { packages = with pkgs; [ vscode ]; };
  };
}
