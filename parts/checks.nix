{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem.pre-commit = {
    settings = {
      excludes = [ "flake.lock" ];
      hooks = {
        deadnix = {
          enable = true;
          verbose = true;
          fail_fast = true;
        };

        nixfmt-classic = {
          enable = true;
          verbose = true;
          fail_fast = true;
        };

        statix = {
          enable = true;
          verbose = true;
          fail_fast = true;
        };
      };
    };
  };
}
