{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.terminal;
  user = config.Ark.userName;
in {
  config.home-manager.users.${user} = mkIf (cfg.emulator == "foot") {
    programs.foot = {
      enable = true;

      settings = {
        main = {
          shell = "${cfg.shell}";

          font = "CaskaydiaCove NF:style=Italic:size=12";
          font-bold = "CaskaydiaCove NF:style=Bold Italic:size=12";
          font-italic = "CaskaydiaCove NF:style=Italic:size=12";
          font-bold-italic = "CaskaydiaCove NF:style=Bold Italic:size=12";

          pad = "20x20";
        };

        colors = {
          alpha = 1;

          background = "1d1f21";
          foreground = "c5c8c6";

          regular0 = "1d1f21";
          regular1 = "d54e53";
          regular2 = "b9ca4a";
          regular3 = "e7c547";
          regular4 = "7aa6da";
          regular5 = "c397d8";
          regular6 = "70c0b1";
          regular7 = "eaeaea";

          bright0 = "666666";
          bright1 = "cc6666";
          bright2 = "b5bd68";
          bright3 = "f0c674";
          bright4 = "81a2be";
          bright5 = "b294bb";
          bright6 = "8abeb7";
          bright7 = "c5c8c6";
        };

        cursor = {
          style = "block";
          blink = "no";
        };
      };
    };

    home.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "CascadiaCode" ]; }) ];
  };
}
