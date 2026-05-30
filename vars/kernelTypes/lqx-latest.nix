inputs:
let
  kernel = rec {
    name = "lqx";
    version = "7.0.10";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-wWDE7Wk43/itkauq9RSmw89qwuckDsfd1I+V2iFx1Hg=";
  };
in
kernel
