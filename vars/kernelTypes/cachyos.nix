inputs:
let
  cachyos-kernel = inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux;
  kernel = {
    bore-lto-v3 = {
      name = "cachyos-bore-lto-v3";
      packages = cachyos-kernel.linuxPackages-cachyos-bore-lto-x86_64-v3;
    };
    server-lto = {
      name = "cachyos-server-lto";
      packages = cachyos-kernel.linuxPackages-cachyos-server-lto;
    };
  };
in
kernel
