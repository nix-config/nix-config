{
  lib,
  opts,
  ...
}:
let
  cfg = opts.container.dev-arch or { };
  finallyEnable = cfg.enable or false && opts.container.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    virtualisation.oci-containers.containers = {
      dev-arch = {
        image = "docker.io/library/archlinux:latest";
        volumes = [
          "/mnt/data/docker/dev-arch/workspace:/root/workspace"
          "/mnt/data/docker/cache/uv:/root/.cache/uv"
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
        ];
      };
    };
  };
}
