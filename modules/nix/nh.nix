{ config, ... }:

let flakeDir = config.Ark.flakeDir;
in {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = flakeDir;
  };
}
