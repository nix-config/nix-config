{
  ...
}:
let
  kernel = rec {
    name = "xanmod";
    version = "7.0.9";
    modDirVersion = "${version}-${name}1";
    url = "https://gitlab.com/xanmod/linux/-/archive/${modDirVersion}.tar.bz2";
    sha256 = "sha256-QYTXvja9SIcV9Za2Lse8eH09Z4DU+GF+xUN3NiEnUd0=";
  };
in
kernel
