{ pkgs }:

let
  inherit (pkgs) lib;
in
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "Neptune-Firefox";
  version = "1.1";

  src = pkgs.fetchFromGitHub {
    repo = pname;
    owner = "yiiyahui";
    rev = "v${version}";
    sha256 = "sha256-Xeof7sSIt0wih9ygh+z2xo6p2Wjh3U6me7HPEUbXu+M=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/neptune-firefox
    cp -r $src/* $out/share/neptune-firefox
  '';

  meta = with lib; {
    description = "A clean and compact Firefox theme.";
    homepage = "https://github.com/yiiyahui/Neptune-Firefox";
    license = licenses.mit;
    maintainers = with maintainers; [ HeartBlin ];
  };
}
