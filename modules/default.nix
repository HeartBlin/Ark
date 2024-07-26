{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) enum str;

  gpus = [ "nvidia" "amd" "intel" "none" ];
in {
  # NixOS modules & homeManager modules are mixed here
  imports = [
    # Modules with no enable option
    ./bootloader
    ./git
    ./kernel
    ./nix
    ./time

    # Modules with an enable option
    ./asus
    ./nvidia
    ./steam
    ./vscode
  ];

  # Hell starts here :*
  options.Ark = {
    flakeDir = mkOption {
      type = str;
      description = "Path to where the flake folder is located on a system";
    };

    hardware = {
      cpu = {

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

    timeZone = mkOption {
      type = str;
      default = "Europe/Bucharest";
      description = "Sets the correct time";
    };
  };

  # User specific config
  options.Ark.home = {
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

    steam.enable = mkEnableOption "Enables Steam";
    vscode.enable = mkEnableOption "Enables VSCode";
  };
}
