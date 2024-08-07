{ config, inputs, lib, ... }:

let
  inherit (lib) mkIf;

  isTwo = config.Ark.home.hyprland.wallpapers.isTwo;
  singleWallpaper = config.Ark.home.hyprland.wallpaper;
  firstWallpaper = config.Ark.home.hyprland.wallpapers.firstWallpaper;

  mat = config.programs.matugen.theme.colors.colors."dark";

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;
  wallpaper = if isTwo then firstWallpaper else singleWallpaper;
in {
  imports = [ inputs.matugen.nixosModules.default ];

  config = mkIf cfg.enable {
    programs.matugen = {
      enable = true;
      wallpaper = wallpaper;
      variant = "dark";
    };

    home-manager.users.${user}.home.file = {
      ".cache/_colors.scss".text = ''
        $surface: #${mat.surface};
        $surfaceContainer: #${mat.surface_container};
        $surfaceContainerHigh: #${mat.surface_container_high};
        $onSurface: #${mat.on_surface};
        $onSurfaceVariant: #${mat.on_surface_variant};

        $primaryContainer: #${mat.primary_container};
        $onPrimaryContainer: #${mat.on_primary_container};

        $secondaryContainer: #${mat.secondary_container};
        $onSecondaryContainer: #${mat.on_secondary_container};
      '';
    };
  };
}
