{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachSystem [
    "x86_64-linux" "x86_64-darwin"
  ] (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      TBuildInputs = [
        pkgs.autoconf269
        pkgs.gcc10
        pkgs.cmake
        pkgs.zlib
        pkgs.bzip2
        pkgs.xz
        pkgs.jre8
        pkgs.jdk8
        pkgs.unzip
        pkgs.perl
        pkgs.perl536Packages.DBFile
        pkgs.python39
        pkgs.python39Packages.numpy
      ];

    in rec {
      devShell = pkgs.mkShell {
        name = "trinity_dev_env";
        buildInputs = TBuildInputs;
      };
    }
  );
}
