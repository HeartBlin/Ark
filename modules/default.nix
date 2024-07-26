{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) enum str;

  gpus = [ "nvidia" "amd" "intel" "none" ];
in {
  # NixOS modules & homeManager modules are mixed here
  imports = [
    # Modules with options
    ./nvidia
  ];

  # Hell starts here :*
  options.Ark = {
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
  };
}
