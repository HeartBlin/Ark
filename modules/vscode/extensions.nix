{ pkgs, ... }:

{
  programs.vscode.extensions = [
    pkgs.vscode-extensions.jnoortheen.nix-ide
    pkgs.vscode-extensions.pkief.material-icon-theme
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
    name = "Everblush";
    publisher = "mangeshrex";
    version = "0.1.1";
    sha256 = "sha256-hqRf3BGQMwFEpOMzpELMKmjS1eg4yPqgTiHQEwi7RUw=";
  }];
}
