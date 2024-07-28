{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.vscode;
  user = config.Ark.userName;
in {
  config.home-manager.users.${user} = mkIf cfg.enable {
    imports = [ ./settings.nix ./extensions.nix ];

    programs.vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      mutableExtensionsDir = true;
    };
  };
}
