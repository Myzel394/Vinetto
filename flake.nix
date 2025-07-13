{
  description = "A Python Package";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        ## Project packages output:
        packages = {
          default = pkgs.python3Packages.buildPythonPackage {
            ## Set the package name:
            pname = "Vinetto";
            version = "0.1.0";

            pyproject = true;

            ## Set the package format:
            # format = "pyproject";

            ## Set the package source:
            src = ./.;

            ## Specify the build system to use:
            build-system = with pkgs.python3Packages; [
              # setuptools
            ];

            propagatedBuildInputs = with pkgs.python3Packages; [
              pillow
              setuptools
              numpy
            ];
          };
        };
      });
}

