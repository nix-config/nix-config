inputs:
let
  kernel = rec {
    name = "xanmod";
    version = "7.0.10";
    modDirVersion = "${version}-${name}1";
    url = "https://gitlab.com/xanmod/linux/-/archive/${modDirVersion}.tar.bz2";
    sha256 = "sha256-Gl+++EfcbCKV+UIJbOpHWN5VhkZTKvA2woxDBonUNOM=";
  };
in
kernel
