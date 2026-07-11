{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.container;
  enableModule = cfg.enable;
  runtimeType = cfg.type;
in
{
  config = lib.mkIf enableModule (
    lib.mkMerge [
      (lib.optionalAttrs (runtimeType == "podman") {
        environment.systemPackages = with pkgs; [
          podman-compose
        ];
        virtualisation = {
          # Podman 配置
          podman = {
            enable = true;
            # 创建一个别名映射 docker 到 podman
            dockerCompat = false;
            # 将 Podman 套接字用于代替 Docker 套接字
            dockerSocket.enable = true;
          };
          # 指定 oci-containers 使用 podman 后端
          oci-containers.backend = "podman";
        };
      })
      (lib.optionalAttrs (runtimeType == "docker") {
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
      })
    ]
  );
}
