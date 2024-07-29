{ inputs, ... }:

{
  config.Ark = {
    audio.enable = false;
    displayManagers.gdm.enable = true;
    flakeDir = ""; # Not in the ISO
    hardware = {
      cpu.type = "none";
      gpu = {
        hybrid = false;
        type = "none"; # Make it work on whatever
      };
    };

    role = "iso";
    secureBoot.enable = false;
    timeZone = "Europe/Bucharest";
    manufacturer = "";

    home = {
      chromium.enable = true;
      git = {
        user = "";
        email = "";
        signKey = "";
      };

      gnome.enable = true;
      hyprland = {
        enable = true;
        cursor = {
          name = "Bibata-Modern-Classic";
          # package is left at default
          size = 25;
        };

        wallpapers = { isTwo = false; };

        wallpaper =
          "${inputs.nixos-artwork}/wallpapers/nix-wallpaper-nineish-dark-gray.png";
      };

      steam.enable = false;
      terminal = {
        emulator = "foot";
        shell = "fish";
        starship.enable = true;
      };
      vscode.enable = true;
    };
  };
}
