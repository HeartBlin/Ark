{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  name = "Walls";
  version = 1.0;
  tn = pkgs.fetchurl {
    url = "https://i.redd.it/ezhnzjo7f7ed1.png";
    hash = "sha256-lT7SN2ibIHYiLOlN9sRQGaNDN+M6WUHJnLaxM830nng=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp $tn $out/share/wallpapers/tokyo-night.png

    runHook postInstall
  '';
}
