{
  lib,
  opts,
  ...
}:
let
  cfg = opts.container.portainer-agent or { };
  finallyEnable = (cfg.enable or false) && opts.container.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    virtualisation.oci-containers.containers = {
      portainer-agent = {
        image = "portainer/agent:latest";
        ports = [
          "9001:9001"
        ];
        volumes = [
          "/:/host"
          "/run/podman/podman.sock:/var/run/docker.sock"
          "/var/lib/containers/storage/volumes:/var/lib/docker/volumes"
        ];
        # 在容器停止或被杀死时自动移除 (禁用, 否则与 --restart 参数冲突)
        autoRemoveOnStop = false;
        # podman run 的额外选项
        extraOptions = [
          "--restart=unless-stopped"
        ];
      };
    };
  };
}
