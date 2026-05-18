{
  ...
}:
let
  kernel = rec {
    name = "latest";
    version = "7.0.9";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-rAes33bPRiHMUYeiZwJwoaaZUzyKayJeSHjEFq2D8cQ=";
  };
in
kernel
