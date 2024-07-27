{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.home.steam;
  user = config.Ark.userName;
in {
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;

      # Proton-GE
      extraCompatPackages = [ pkgs.proton-ge-bin.steamcompattool ];

      # Firewall
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = false;
    };

    users.users."${user}".packages = [ pkgs.protontricks ];
  };
}
