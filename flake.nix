{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    pnpm2nix = {
      url = "github:nzbr/pnpm2nix-nzbr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        inputs',
        self',
        ...
      }: {
        formatter = pkgs.alejandra;

        packages = rec {
          sondehub-api = pkgs.callPackage ./. {};
          default = sondehub-api;
        };

        checks = (
          {
            lint = pkgs.callPackage ./checks/lint.nix {};
          }
          // self'.packages
        );

        devShells.default = pkgs.mkShell {
          inputsFrom = builtins.attrValues self'.packages;
        };
      };
    };
}
