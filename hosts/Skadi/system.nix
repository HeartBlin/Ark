{ pkgs, self, ... }:

{
  config.Ark = {
    displayManagers.gdm.enable = true;
    flakeDir = "/home/heartblin/Documents/Ark";
    hardware = {
      cpu.type = "amd";
      gpu = {
        hybrid = true;
        type = "nvidia";
        ids = {
          amd = "PCI:6:0:0";
          nvidia = "PCI:1:0:0";
        };
      };
    };

    secureBoot.enable = true;
    timeZone = "Europe/Bucharest";
    manufacturer = "asus";

    home = {
      chromium.enable = true;
      git = {
        user = "HeartBlin";
        email = "Manea.Emil@proton.me"; # Doxxed lel
        signKey = "~/.ssh/GithubSign.pub";
      };

      gnome.enable = true;
      hyprland = {
        enable = true;
        cursor = {
          name = "Bibata-Modern-Classic";
          # package is left at default
          size = 25;
        };

        wallpapers = {
          isTwo = true;
          firstWallpaper =
            "${self.packages.${pkgs.system}.Walls}/share/wallpapers/Sony_1.jpg";
          secondWallpaper =
            "${self.packages.${pkgs.system}.Walls}/share/wallpapers/Sony_2.jpg";
        };
      };

      steam.enable = true;
      terminal = {
        emulator = "foot";
        shell = "fish";
        starship.enable = true;
      };
      vscode.enable = true;
    };
  };
}
