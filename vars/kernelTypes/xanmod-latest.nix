{
  ...
}:
let
  kernel = rec {
    name = "xanmod";
    version = "7.0.8";
    modDirVersion = "${version}-${name}1";
    url = "https://gitlab.com/xanmod/linux/-/archive/${modDirVersion}.tar.bz2";
    sha256 = "sha256-eUYVQhG0V5yCUjxLV9jOYgLNVpuS7KaDL56Y1n4OYLc=";
  };
in
kernel
