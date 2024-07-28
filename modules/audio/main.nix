{ config, lib, ... }:

let
  inherit (lib) mkIf;

  cfg = config.Ark.audio;
in {
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };

    hardware.pulseaudio.enable = lib.mkForce false;
  };
}
