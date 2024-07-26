{ inputs, self }:

{
  hostImport = { hostName, userName }:
    let state = "24.11";
    in [
      # Paths for the host
      "${self}/hosts/${hostName}/hardware.nix"
      "${self}/hosts/${hostName}/system.nix"

      # Module paths
      "${self}/modules"

      # Home-Manager import
      inputs.home-manager.nixosModules.home-manager

      # Set hostname & easy way to access it
      ({ lib, ... }: {
        config = {
          networking.hostName = "${hostName}";
          system.stateVersion = "${state}";
        };

        options.Ark.hostName = lib.mkOption {
          type = with lib.types; str;
          default = "${hostName}";
        };
      })

      # Set username & home-manager config
      ({ lib, ... }: {
        config = {
          users.users."${userName}" = {
            isNormalUser = true;
            extraGroups = [ "wheel" "video" ];
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users."${userName}" = {
              programs.home-manager.enable = true;
              home.stateVersion = "${state}";
            };
          };
        };

        options.Ark.userName = lib.mkOption {
          type = with lib.types; str;
          default = "${userName}";
        };
      })
    ];
}
