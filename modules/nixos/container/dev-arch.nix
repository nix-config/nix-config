{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.container.dev-arch.enable && opts.container.enable;
in
{
  config = lib.mkIf enableModule {
    virtualisation.oci-containers.containers = {
      dev-arch = {
        image = "docker.io/library/archlinux:latest";
        volumes = [
          "/mnt/data/docker/cache/uv:/root/.cache/uv"
          "/mnt/data/docker/dev-arch/workspace:/root/workspace"
          "/mnt/data/docker/cache/.vscode-server:/root/.vscode-server"
          "/mnt/data/docker/cache/.vscode-server:/root/.trae-cn-server"
        ];
        # 共许容器访问所有 Nvidia 设备
        devices = [ "nvidia.com/gpu=all" ];
        # 让容器保持后台运行
        entrypoint = "sleep";
        cmd = [ "infinity" ];
        autoRemoveOnStop = false;
        extraOptions = [
          "--privileged"
          "--network=host"
          "--restart=unless-stopped"
          "--workdir=/root/workspace"
        ];
      };
    };
  };
}
