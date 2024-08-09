{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  name = "Walls";
  version = 1.1;
  tn = pkgs.fetchurl {
    url = "https://i.redd.it/ezhnzjo7f7ed1.png";
    hash = "sha256-lT7SN2ibIHYiLOlN9sRQGaNDN+M6WUHJnLaxM830nng=";
  };

  cf = pkgs.fetchurl {
    url = "https://backiee.com/static/wallpapers/1920x1080/369161.jpg";
    hash = "sha256-1hma76HtQXrMlB8Wvaav2Ua+7BYPaesFWCXZp8G5PbI=";
  };

  spiral1 = pkgs.fetchurl {
    url =
      "https://drive.usercontent.google.com/download?id=0B08Ro4V-3VhoNHNqZWtyZGpfSEk&export=download&resourcekey=0-jTWpHMnTl2OYgvMdJOnmhA";
    hash = "sha256-+f26u+P3i2FWqmjtGjYEOi4/obpY0K4ERG1chtrL2KY=";
  };

  spiral2 = pkgs.fetchurl {
    url = "https://drive.usercontent.google.com/download?id=0B08Ro4V-3VhoYnFlNzBGRlNTWFk&export=download&resourcekey=0-mdDr5EkQw1EiOXh96g5eqw";
    hash = "sha256-xk2SaXyzjHk9yzsaW4EH47CfWkGdJRqE86pDWkZi7g0=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp $tn $out/share/wallpapers/tokyo-night.png
    cp $cf $out/share/wallpapers/crimson-foliage.jpg
    cp $spiral1 $out/share/wallpapers/Spiral_6A.jpg
    cp $spiral2 $out/share/wallpapers/Spiral_3A.jpg

    runHook postInstall
  '';
}
