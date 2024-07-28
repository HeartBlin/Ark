{ lib, pkgs, ... }:

# Credits for this function go to evanjs
# https://github.com/evanjs/nixos_cfg/blob/4bb5b0b84a221b25cf50853c12b9f66f0cad3ea4/config/new-modules/default.nix
# The MIT license applies to these functions
# getDirectory, files and allDefaultFiles
# https://github.com/evanjs/nixos_cfg/blob/4bb5b0b84a221b25cf50853c12b9f66f0cad3ea4/LICENSE

let
  inherit (lib)
    collect concatStringsSep filter hasSuffix isString mapAttrs
    mapAttrsRecursive mkEnableOption mkOption;
  inherit (lib.types) enum int package str;

  cpus = [ "amd" "intel" ];
  gpus = [ "nvidia" "amd" "intel" "none" ];

  getDirectory = dir:
    mapAttrs (file: type:
      if type == "directory" then getDirectory "${dir}/${file}" else type)
    (builtins.readDir dir);

  files = dir:
    collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path)
      (getDirectory dir));

  allDefaultFiles = dir:
    map (file: ./. + "/${file}") (filter
      (file: hasSuffix "main.nix" file
      ) (files dir));
in {
  # NixOS modules & homeManager modules are mixed here
  imports = allDefaultFiles ./.;

  # Hell starts here :*
  options.Ark = {
    audio.enable = mkEnableOption "Enable audio (pipewire)";
    displayManagers.gdm.enable = mkEnableOption "Enable GDM";
    flakeDir = mkOption {
      type = str;
      description = "Path to where the flake folder is located on a system";
    };

    hardware = {
      cpu.type = mkOption {
        type = enum cpus;
        description = "The CPU currently installed";
      };

      gpu = {
        hybrid = mkEnableOption "Whether or not the system has hybrid graphics";
        ids = {
          amd = mkOption {
            type = str;
            default = "";
            description = "ID of AMD GPU";
          };

          intel = mkOption {
            type = str;
            default = "";
            description = "ID of Intel GPU";
          };

          nvidia = mkOption {
            type = str;
            default = "";
            description = "ID of Nvidia GPU";
          };
        };

        type = mkOption {
          type = enum gpus;
          default = "none";
          description = "The GPU currently installed";
        };
      };
    };

    manufacturer = mkOption {
      type = str;
      default = "";
      description = "Manufacturer of PC";
    };

    secureBoot.enable = mkEnableOption "Enable SecureBoot";
    timeZone = mkOption {
      type = str;
      default = "Europe/Bucharest";
      description = "Sets the correct time";
    };
  };

  # User specific config
  options.Ark.home = {
    chromium.enable = mkEnableOption "Enable ungoogled-chromium";
    git = {
      user = mkOption {
        type = str;
        description = "Username that git uses";
      };

      email = mkOption {
        type = str;
        description = "Email address that git uses";
      };

      signKey = mkOption {
        type = str;
        description = "SSH key used for signing commits";
      };
    };

    gnome.enable = mkEnableOption "Enable Gnome";
    hyprland = {
      enable = mkEnableOption "Enable Hyprland";

      cursor = {
        name = mkOption {
          type = str;
          default = "Bibata-Modern-Ice";
        };

        package = mkOption {
          type = package;
          default = pkgs.bibata-cursors;
        };

        size = mkOption {
          type = int;
          default = 25;
        };
      };

      wallpaper = mkOption {
        type = str;
        default = "";
        description = "Takes either a path or a .outPath";
      };

      wallpapers = {
        isTwo = mkEnableOption
          "Whether or not to use 2 different wallpapers for 2 displays";
        firstWallpaper = mkOption {
          type = str;
          default = "";
        };

        secondWallpaper = mkOption {
          type = str;
          default = "";
        };
      };
    };

    steam.enable = mkEnableOption "Enable Steam";
    terminal = {
      emulator = mkOption {
        type = str;
        default = "foot";
      };

      shell = mkOption {
        type = str;
        default = "fish";
      };

      starship.enable = mkEnableOption "Enable StarShip";
    };

    vscode.enable = mkEnableOption "Enable VSCode";
  };
}
