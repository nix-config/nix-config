{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.9";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-YCEMOk2ssMzSQ21VazXLGHHOULVrT8drj8DSxuV5MqI=";
  };
in
kernel
