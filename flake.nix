{
  description = "Fetch latest source for all derivations in a package";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    cl-nix-lite = {
      flake = false;
      url = "github:hraban/cl-nix-lite";
    };
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
    winfer-src = {
      url = "github:privet-kitty/wild-package-inferred-system";
      flake = false;
    };
  };
  outputs = {
    self, nixpkgs, cl-nix-lite, gitignore, flake-utils, infix-src, wu-src, winfer-src
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cleanSource = src: gitignore.lib.gitignoreSource (pkgs.lib.cleanSource src);
        lispPackagesLite = import cl-nix-lite { inherit pkgs; };
      in
      with lispPackagesLite;
      let
        wu = lispDerivation {
          lispSystem = "wu-decimal";
          src = wu-src;
        };
        winfer = lispDerivation {
          lispSystem = "wild-package-inferred-system";
          src = winfer-src;
          lispCheckDependencies = [ fiveam ];
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
                rutils
                winfer
              ];
              dontStrip = true;
              src = cleanSource ./.;
              meta = {
                license = pkgs.lib.licenses.agpl3Only;
              };
            };
          };
        });
  }
