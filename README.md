# nixpkgs-configurable

> `config` and `overlays`, now in flakes!

This is something I came up with after dealing with overlays, cross-compilation
in flakes, global overriding of packages, and performance of Nix
implementations. It's heavily inspired by other amazing uses of dependency
injection like [nixpkgs-unfree](https://github.com/numtide/nixpkgs-unfree) and
[nix-systems](https://github.com/nix-systems/nix-systems).

## Usage

Aside from overriding the `arguments` input, you can use `nixpkgs-configurable` just like nixpkgs

```
{
  inputs = {
    nixpkgs-src.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs = {
      url = "github:getchoo/nixpkgs-configurable";
      inputs = {
        arguments.follows = "nixpkgs-arguments";

        # Optional. By default, `nixpkgs-unstable` is used
        nixpkgs-src.follows = "nixpkgs-src";
      };
    };

    nixpkgs-arguments = {
      url = "path:./arguments.nix";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }: {
    packages.x86_64-linux = { inherit (nixpkgs.legacyPackages.x86_64-linux) hello-unfree };
  };
}
```

with `arguments.nix` containing:

```nix
{
  config = {
    allowUnfree = true;
  };
}
```
