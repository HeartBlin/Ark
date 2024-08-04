pkgs: {
  hyprZoom = pkgs.callPackage ./hyprZoom { inherit pkgs; };
  neptune = pkgs.callPackage ./neptune { inherit pkgs; };
  Walls = pkgs.callPackage ./Walls { inherit pkgs; };
}
