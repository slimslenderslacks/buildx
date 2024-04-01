{
  description = "buildx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, ... }@inputs:
      inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = import ./buildx.nix {
          lib = pkgs.lib;
          buildGoModule = pkgs.buildGoModule;
          fetchFromGitHub = pkgs.fetchFromGitHub;
        };
      });
  }
