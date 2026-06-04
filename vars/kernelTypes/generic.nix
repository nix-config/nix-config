inputs:
let
  kernel = {
    latest = rec {
      name = "generic";
      version = "7.0.11";
      modDirVersion = "${version}";
      url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
      sha256 = "sha256-5WyDVt2gETamBBxu+DK9Dsmb0tNd/5eDKqXsEO0BQwQ=";
    };
  };
in
kernel
