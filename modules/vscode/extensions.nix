{ pkgs, ... }:

{
  programs.vscode.extensions = [
    pkgs.vscode-extensions.jnoortheen.nix-ide
    pkgs.vscode-extensions.pkief.material-icon-theme
    pkgs.vscode-extensions.esbenp.prettier-vscode
  ];
}
