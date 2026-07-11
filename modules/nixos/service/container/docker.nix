{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = (opts.service.container.type == "docker");
in
{
  config = lib.mkIf enableModule {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
    virtualisation = {
      # Docker 配置
      docker = {
        enable = true;
      };
      # 指定 oci-containers 使用 docker 后端
      oci-containers.backend = "docker";
    };
  };
}
