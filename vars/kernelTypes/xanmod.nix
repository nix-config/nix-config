inputs:
let
  kernel = {
    latest = rec {
      name = "xanmod";
      version = "7.0.11";
      modDirVersion = "${version}-${name}1";
      url = "https://gitlab.com/xanmod/linux/-/archive/${modDirVersion}.tar.bz2";
      sha256 = "sha256-6OxIWEElBgj/zW+0d9plG8wv8urL0A0aW8lcO7M5+qQ=";
    };
  };
in
kernel
