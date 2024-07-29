{ pkgs }:

pkgs.buildGoModule rec {
  pname = "hypr-zoom";
  version = "0.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "FShou";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-JBLywYJl45mGJTlhvqPzVpoU9sinkqzAyoECOcSH/eU=";
  };

  vendorHash = "sha256-BCx2hKi6U/MPJlwAmnM4/stiolhYkakpe4EN3e5r6L4=";
}
