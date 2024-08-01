{ inputs, ... }:

{
  config.Ark = {
    audio.enable = true;
    displayManagers = {
      gdm.enable = true;
      sddm.enable = false;
    };
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

    role = "laptop";
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

        wallpapers = let
          nixos =
            "${inputs.nixos-artwork}/wallpapers/nix-wallpaper-nineish-dark-gray.png";
        in {
          isTwo = true;
          firstWallpaper = nixos;
          secondWallpaper = nixos;
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
