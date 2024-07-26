{ config, lib, pkgs, ... }:

let cfg = config.Ark.manufacturer;
in {
  config = lib.mkIf (cfg == "asus") {
    services.asusd = {
      enable = true;
      enableUserService = true;
      package = pkgs.asusctl;
    };

    services.supergfxd.enable = true;
  };
}
