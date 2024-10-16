{ inputs, libx, self, withSystem }:

{
  mkSystem = { hostName, userName, prettyName ? "", system ? "x86_64-linux"
    , stateVersion ? "24.11", timeZone ? "Europe/Bucharest"
    , flakeDir ? "/home/${userName}/Mint" }:
    withSystem system ({ inputs', self', ... }:
      let
        inherit (inputs.nixpkgs.lib) nixosSystem;
        inherit (inputs.nixpkgs.lib) mkOption;
        inherit (inputs.nixpkgs.lib.types) nullOr str;

        commonArgs = {
          inherit hostName inputs inputs' libx prettyName self self' userName;
        };

        inputModules = with inputs; [
          chaotic.nixosModules.default
          disko.nixosModules.disko
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          lix.nixosModules.default
        ];

        pathModules = [
          "${self}/hosts/${hostName}/config.nix"
          "${self}/hosts/${hostName}/hardware"
          "${self}/modules"
        ];

      in nixosSystem {
        specialArgs = commonArgs;

        modules = inputModules ++ pathModules ++ [
          # Options
          { nixpkgs.hostPlatform.system = system; }
          { system.stateVersion = stateVersion; }
          { networking.hostName = hostName; }
          { time.timeZone = timeZone; } # Override this if needed
          { time.hardwareClockInLocalTime = true; } # DualBoot lmao
          {
            users.users."${userName}" = {
              isNormalUser = true;
              description = prettyName;
              initialPassword = "changeme";
              extraGroups = [ "wheel" ];
            };

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = commonArgs;

              users.${userName} = {
                imports = [
                  # Modules
                  inputs.mintwalls.homeManagerModules.mintWalls

                  # Paths
                  "${self}/hosts/${hostName}/user/config.nix"

                  # Options
                  { programs.home-manager.enable = true; }
                  { home.stateVersion = stateVersion; }
                ];
              };
            };
          }

          # Inform the system where the flake is
          {
            options.Mint.flakeDir = mkOption {
              type = nullOr str;
              readOnly = true;
              default = flakeDir;
            };
          }

          # Set pfp
          {
            system.activationScripts.profilePicture.text = ''
              mkdir -p /var/lib/AccountsService/{icons,users}
              cp /home/${userName}/Mint/hosts/${hostName}/user/pfp.png /var/lib/AccountsService/icons/${userName}
              echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${userName}\n" > /var/lib/AccountsService/users/${userName}
            '';
          }
        ];
      });
}
