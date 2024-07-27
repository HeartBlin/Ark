{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.terminal;
  user = config.Ark.userName;
  flakeDir = config.Ark.flakeDir;
in {
  config.home-manager.users.${user} = mkIf (cfg.shell == "fish") {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set -gx FLAKE ${flakeDir}
      '';

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza -l";
        rebuild = "nh os switch";
        boot = "nh os boot";
        update = "nix flake update --flake ${flakeDir} && nh os switch";
        clean = "nh clean all && nh os boot";
      };
    };
  };
}
