{
  ...
}:
let
  kernel = rec {
    name = "lqx";
    version = "7.0.8";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-ad585eS7P/b9oKhDipyStXWg+BFCLRJbMEt9+KbvBJQ=";
  };
in
kernel
