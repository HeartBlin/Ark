{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;

  createChromiumExtensionFor = x:
    { id, sha256, version, }: {
      inherit id;
      crxPath = builtins.fetchurl {
        url =
          "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${x}&x=id%3D${id}%26installsource%3Dondemand%26uc";
        name = "${id}.crx";
        inherit sha256;
      };
      inherit version;
    };

  createChromiumExtension = createChromiumExtensionFor
    (lib.versions.major pkgs.ungoogled-chromium.version);

  cfg = config.Ark.home.chromium;
  user = config.Ark.userName;
in {
  config.home-manager.users.${user} = mkIf cfg.enable {
    programs.chromium = {
      enable = true;

      extensions = [
        # BitWarden
        (createChromiumExtension {
          id = "nngceckbapebfimnlniiiahkandclblb";
          sha256 = "14mk4x3nggkggf68a3bafry9vk54yxcxlsczzs4qmp7m03y16a1n";
          version = "2024.6.2";
        })

        # uBlock Origin
        (createChromiumExtension {
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "01kk94l38qqp2rbyylswjs8q25kcjaqvvh5b8088xria5mbrhskl";
          version = "1.58.0";
        })
      ];

      package = pkgs.ungoogled-chromium.override {
        commandLineArgs = [
          "--force-punycode-hostnames"
          "--hide-crashed-bubble"
          "--popups-to-tabs"
          "--hide-fullscreen-exit-ui"
          "--hide-sidepanel-button"
          "--remove-tabsearch-button"
          "--show-avatar-button=never"
          "--force-dark-mode"
          "--no-default-browser-check"

          "--gtk-version=4"
          "--enable-gpu-rasterization"
          "--enable-oop-rasterization"
          "--enable-zero-copy"
          "--ignore-gpu-blocklist"

          "--enable-features=VaapiVideoDecoder"

          "--password-store=gnome"
        ];
      };
    };
  };
}
