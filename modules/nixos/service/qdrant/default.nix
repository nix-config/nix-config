{
  lib,
  pkgs,
  opts,
  ...
}:
let
  # TODO: 临时禁用 avx512vnni, LLVM 21 修改了 vpdpbusd 内在函数签名
  # 但 nixpkgs 的 rustc LLVM 尚未更新, 导致 quantization crate 编译失败
  package = pkgs.qdrant.overrideAttrs (oa: {
    patches = (oa.patches or [ ]) ++ [
      ./0001-disable-avx512vnni.patch
    ];
  });
  firewall = opts.hardware.networking.firewall;
  inherit (opts.service.qdrant) instances;
in
{
  config = lib.mkIf opts.service.qdrant.enable {
    containers = builtins.listToAttrs (
      map (inst: {
        name = inst.name;
        value = {
          autoStart = true;
          privateNetwork = false;
          config = { ... }: {
            services.qdrant = {
              enable = true;
              inherit package;
              settings = {
                service.host = "0.0.0.0";
                service.port = inst.port;
                service.grpc_port = inst.port + 1;
              };
            };
            networking.firewall = firewall;
            system.stateVersion = opts.stateVersion;
          };
        };
      }) instances
    );
  };
}
