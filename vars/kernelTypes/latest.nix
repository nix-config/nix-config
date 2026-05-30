inputs:
let
  kernel = rec {
    name = "latest";
    version = "7.0.10";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-CUl362LCDj0ZOf6BqSlYofmH8zlEblMvqGljsoBOMtw=";
  };
in
kernel
