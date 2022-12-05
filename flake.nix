{
  description = "Demo lispPackagesLite app using flakes";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    hly-nixpkgs.url = "github:hraban/nixpkgs/feat/lisp-packages-lite";
    gitignore = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/gitignore.nix";
    };
  };
  outputs = {
    self, nixpkgs, hly-nixpkgs, gitignore, flake-utils
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cleanSource = src: gitignore.lib.gitignoreSource (pkgs.lib.cleanSource src);
        inherit (pkgs.callPackage hly-nixpkgs {}) lispPackagesLite;
      in
      with lispPackagesLite;
        {
          packages = {
            default = lispDerivation {
              lispSystem = "aoc-2022";
              lispDependencies = [
                asdf
                alexandria
                arrow-macros
                cl-utilities
              ];
              src = cleanSource ./.;
              meta = {
                license = "AGPLv3";
              };
            };
          };
        });
  }
