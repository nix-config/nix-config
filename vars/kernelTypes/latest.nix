{
  ...
}:
let
  kernel = rec {
    name = "latest";
    version = "7.0.8";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-GUWvsiyfT3x42XEhDzu7fesJ9djEGji/rHct4l9tyyI=";
  };
in
kernel
