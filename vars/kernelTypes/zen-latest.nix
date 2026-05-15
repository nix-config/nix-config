{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.7";
    modDirVersion = "${version}-${name}2";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-qcwOOGUnpwJYkxn52zAClZko9Yux0sskc3ECrpHDG0U=";
  };
in
kernel
