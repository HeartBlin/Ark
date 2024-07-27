{ config, lib, ... }:

let
  inherit (lib) mkIf;

  fishEnabled = config.Ark.home.terminal.shell == "fish";

  cfg = config.Ark.home.terminal;
  user = config.Ark.userName;
in {
  config.home-manager.users.${user} = mkIf cfg.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = fishEnabled;

      settings = {
        add_newline = false;

        character = {
          disabled = false;
          success_symbol = "[λ](bold purple)";
          error_symbol = "[λ](bold red)";
        };

        directory = { disabled = false; };
      };
    };
  };
}
