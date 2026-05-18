{
  ...
}:
let
  kernel = rec {
    name = "lqx";
    version = "7.0.9";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-f/c8fvBpDsWn1ZvGFkVBxlr6oHcHlNPUPiU0hymVFRw=";
  };
in
kernel
