{
  inputs = {
    nixpkgs = {
      url = "path:../.";
      inputs.arguments.follows = "arguments";
    };

    arguments = {
      url = "path:./test-arguments.nix";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, ... }:

    let
      inherit (nixpkgs) lib;
    in

    {
      checks = lib.genAttrs lib.systems.flakeExposed (system: {
        inherit (nixpkgs.legacyPackages.${system}) hello-unfree;
      });
    };
}
