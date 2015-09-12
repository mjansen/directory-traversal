{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7101" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, directory, filepath, stdenv }:
      mkDerivation {
        pname = "directory-traversal";
        version = "0.1.0.0";
        src = ./.;
        buildDepends = [ base directory filepath ];
        description = "simple directory traversal";
        license = stdenv.lib.licenses.mit;
      };

  drv = pkgs.haskell.packages.${compiler}.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
