inputs:
let
  kernel = {
    latest = rec {
      name = "zen";
      version = "7.0.11";
      modDirVersion = "${version}-${name}1";
      url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
      sha256 = "sha256-cRQRMoLAB0cuX4mhakMOBBnl/ph0q1cCwYZ9iN80Dqo=";
    };
    lqx-latest = rec {
      name = "lqx";
      version = "7.0.11";
      modDirVersion = "${version}-${name}1";
      url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
      sha256 = "sha256-MJV55c0qxmqVhGxlcrHY2wRn0u3uQ/hefEVy00vmm70=";
    };
  };
in
kernel
