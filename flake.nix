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

    # Wayland compositor & Related
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # SecureBoot support
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    # Artwork
    nixos-artwork.url = "github:NixOS/nixos-artwork";
    nixos-artwork.flake = false;
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs.lib) genAttrs nixosSystem;

      # I don't have any other systems
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = genAttrs supportedSystems;

      specialArgs = { inherit inputs self; };

      hostImport = (import ./lib { inherit inputs self; }).hostImport;
      isoImport = (import ./lib { inherit inputs self; }).isoImport;
    in {
      nixosConfigurations = {
        Skadi = nixosSystem {
          specialArgs = specialArgs;
          modules = hostImport {
            hostName = "Skadi"; # Duh
            userName = "heartblin";
          };
        };

        Specter = nixosSystem {
          specialArgs = specialArgs;
          modules = isoImport { hostName = "Specter"; };
        };
      };

      packages = forAllSystems
        (system: import ./packages nixpkgs.legacyPackages.${system});

      # Other ones look bad
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-classic);
    };
}
