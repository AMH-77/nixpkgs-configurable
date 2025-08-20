{
  inputs = {
    nixpkgs-src.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    arguments = {
      url = "path:./arguments.nix";
      flake = false;
    };
  };

  outputs =
    { nixpkgs-src, arguments, ... }:

    let
      inherit (nixpkgs-src) lib;

      forEachFlakeSystem = lib.genAttrs lib.systems.flakeExposed;
    in

    {
      # Re-export other (public) parts of the nixpkgs API
      inherit (nixpkgs-src) lib nixosModules;

      legacyPackages = forEachFlakeSystem (
        system: import nixpkgs-src ({ inherit system; } // import arguments)
      );
    };
}
