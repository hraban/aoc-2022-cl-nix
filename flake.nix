{
  description = "Demo lispPackagesLite app using flakes";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    hly-nixpkgs.url = "github:hraban/nixpkgs/feat/lisp-packages-lite";
    gitignore = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hercules-ci/gitignore.nix";
    };
    infix-src = {
      url = "github:ruricolist/infix-math";
      flake = false;
    };
    wu-src = {
      url = "github:Wukix/wu-decimal";
      flake = false;
    };
  };
  outputs = {
    self, nixpkgs, hly-nixpkgs, gitignore, flake-utils, infix-src, wu-src
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cleanSource = src: gitignore.lib.gitignoreSource (pkgs.lib.cleanSource src);
        inherit (pkgs.callPackage hly-nixpkgs {}) lispPackagesLite;
      in
      with lispPackagesLite;
      let
        wu = lispDerivation {
          lispSystem = "wu-decimal";
          src = wu-src;
        };
        infix-math = lispDerivation {
          lispSystem = "infix-math";
          lispDependencies = [ alexandria serapeum wu parse-number ];
          src = infix-src;
        };
      in
        {
          packages = {
            default = lispDerivation {
              name = "aoc-2022x";
              lispSystem = "aoc-2022x";
              lispDependencies = [
                asdf
                alexandria
                arrow-macros
                cl-utilities
                infix-math
              ];
              src = cleanSource ./.;
              meta = {
                license = "AGPLv3";
              };
            };
          };
        });
  }
