{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  name = "Walls";
  version = 1.0;
  src = ./src;
  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp -r $src/* $out/share/wallpapers

    runHook postInstall
  '';
}
