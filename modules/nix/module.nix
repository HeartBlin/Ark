{ config, pkgs, ... }:

let inherit (config.Ark) flakeDir;
in {
  nix = {
    package = pkgs.lix;
    settings = {
      experimental-features = [ "flakes" "nix-command" ];

      # Caches
      substituters = [
        "https://cache.nixos.org?priority=10" # Funny
        "https://cache.ngi0.nixos.org/" # CA nix
        "https://nix-community.cachix.org" # Community
        "https://nixpkgs-unfree.cachix.org" # Unfree 1
        "https://numtide.cachix.org" # Unfree 2
        "https://nixpkgs-wayland.cachix.org" # Wayland
        "https://hyprland.cachix.org" # Hyprland
        "https://nyx.cachix.org" # Foot-transparent
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nyx.cachix.org-1:xH6G0MO9PrpeGe7mHBtj1WbNzmnXr7jId2mCiq6hipE="
      ];
    };
  };

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = flakeDir;
  };
}
