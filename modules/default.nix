{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) enum str;

  gpus = [ "nvidia" "amd" "intel" "none" ];
in {
  # NixOS modules & homeManager modules are mixed here
  imports = [
    # Modules with no options
    ./bootloader
    ./kernel
    ./nix
    ./time

    # Modules with options
    ./nvidia
    ./steam
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

    timeZone = mkOption {
      type = str;
      default = "Europe/Bucharest";
      description = "Sets the correct time";
    };
  };

  # User specific config
  options.Ark.home = { steam.enable = mkEnableOption "Enables Steam"; };
}
