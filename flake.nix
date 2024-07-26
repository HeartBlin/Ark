{
  description = "";

  inputs = {
    # Unstable, it works better than stable sometimes
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # CachyOS kernel provider
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Home management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (nixpkgs.legacyPackages.${system}) nixfmt-classic;

      # I don't have any other systems
      system = "x86_64-linux";

      specialArgs = { inherit inputs self; };

      hostImport = (import ./lib { inherit inputs self; }).hostImport;
    in {
      nixosConfigurations = {
        Skadi = nixosSystem {
          specialArgs = specialArgs;
          modules = hostImport {
            hostName = "Skadi"; # Duh
            userName = "heartblin";
          };
        };
      };

      formatter.${system} = nixfmt-classic;
    };
}
