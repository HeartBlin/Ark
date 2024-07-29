pkgs: {
  hyprZoom = pkgs.callPackage ./hyprZoom { inherit pkgs; };
  Walls = pkgs.callPackage ./Walls { inherit pkgs; };
}
