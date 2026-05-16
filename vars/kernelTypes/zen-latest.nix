{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.8";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-zk/nlqbVZABxQYIn/dop9JISV7BQsK4bkGD0bGodvwM=";
  };
in
kernel
