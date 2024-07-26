{ config, ... }:

let cfg = config.Ark;
in {
  time.timeZone = cfg.timeZone;
  time.hardwareClockInLocalTime = true;
}
