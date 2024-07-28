{ pkgs, ... }:

{
  imports = [ ./docs.nix ./nh.nix ./substituters.nix ];

  nix = {
    package = pkgs.nixVersions.git;

    settings = {
      auto-optimise-store = true;

      allowed-users = [ "root" "@wheel" "nix-builder" ];
      trusted-users = [ "root" "@wheel" "nix-builder" ];

      max-jobs = "auto";

      # Run builds in sandbox
      sandbox = true;
      sandbox-fallback = false;

      # Allow flakes and cgroups
      experimental-features = [ "flakes" "nix-command" "cgroups" ];

      builders-use-substitutes = true;

      # Use cgroups
      use-cgroups = true;

      # Shut up
      warn-dirty = false;
    };
  };

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
    permittedInsecurePackages = [ ];
  };

  environment.systemPackages = [ pkgs.git ];
  environment.defaultPackages = [ ];
}
