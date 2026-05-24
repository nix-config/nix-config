{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.10";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-85wjUNtWc4UqGughRmcSPpIJDktxkj3Z6e4nTLaeqmg=";
  };
in
kernel
