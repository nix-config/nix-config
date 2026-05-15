{
  ...
}:
let
  kernel = rec {
    name = "latest";
    version = "7.0.7";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-yOH+hqOq/y3m90ATg/lZKDUQw4n/hMFatxHI+86yXfQ=";
  };
in
kernel
