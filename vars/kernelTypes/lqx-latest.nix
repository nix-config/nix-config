{
  ...
}:
let
  kernel = rec {
    name = "lqx";
    version = "7.0.7";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-ynWfmFIYADVPwFEHHXAkfQPDB2h7G8u4nQxscd8umeo=";
  };
in
kernel
