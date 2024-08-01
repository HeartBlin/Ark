{ lib, ... }:

let inherit (lib) mkForce;
in {
  imports = [ ./plymouth.nix ./secureBoot.nix ];

  boot.loader.timeout = mkForce 0;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    editor = true;
  };
}
