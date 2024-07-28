{ config, lib, ... }:

let
  inherit (lib) mkIf;

  role = config.Ark.role;
  flakeDir = config.Ark.flakeDir;
in {
  config = mkIf (role != "iso") {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
      flake = flakeDir;
    };
  };
}
