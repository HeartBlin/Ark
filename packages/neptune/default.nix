{ pkgs }:

let inherit (pkgs) lib;
in pkgs.stdenvNoCC.mkDerivation rec {
  pname = "Neptune-Firefox";
  version = "95eff1707656a1ee78cc3365869996dfa64a4bf2";

  src = pkgs.fetchFromGitHub {
    repo = pname;
    owner = "HeartBlin"; # Forked it to fix padding issues
    rev = "${version}";
    sha256 = "sha256-BCoEJG5DNfNYNXgZ5RHe9/+26Sfc+fTMgFvT6AVwP2M=";
  };

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
