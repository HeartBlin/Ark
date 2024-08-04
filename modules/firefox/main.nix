{ config, inputs, lib, pkgs, self, ... }:

let
  inherit (lib) mkIf;

  theme = self.packages.${pkgs.system}.neptune;

  cfg = config.Ark.home.firefox;
  user = config.Ark.userName;
in {
  config.home-manager.users.${user} = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.${user} = {
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          adaptive-tab-bar-colour
          bitwarden
          darkreader
          ublock-origin
        ];

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.newtabpage.activity-stream.newtabWallpapers.enabled" = true;
          "browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled" =
            true;
          "widget.non-native-theme.scrollbar.style" = 2;
          "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" =
            false;
        };

        userChrome = ''
          @import "${theme}/share/neptune-firefox/chrome/userChrome.css"
        '';

        userContent = ''
          @import "${theme}/share/neptune-firefox/chrome/userContent.css";
        '';
      };
    };
  };
}
