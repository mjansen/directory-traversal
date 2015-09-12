{ mkDerivation, base, directory, filepath, stdenv }:
mkDerivation {
  pname = "directory-traversal";
  version = "0.1.0.0";
  src = ./.;
  buildDepends = [ base directory filepath ];
  description = "simple directory traversal";
  license = stdenv.lib.licenses.mit;
}
