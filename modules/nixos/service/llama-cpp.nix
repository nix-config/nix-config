{
  lib,
  pkgs,
  opts,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  inherit (opts.service.llama-cpp)
    extraSettings
    host
    port
    ;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
in
{
  config = lib.mkIf enableModule (
    lib.mkMerge [
      {
        services.llama-cpp = {
          enable = true;
          package = pkgs.llama-cpp.override { cudaSupport = true; };
          settings = lib.mkMerge [
            {
              inherit
                host
                port
                ;
            }
            extraSettings
          ];
          # 是否开放防火墙端口
          openFirewall = true;
        };
      }
      (lib.optionalAttrs isWsl {
        systemd.services.llama-cpp = {
          environment.LD_LIBRARY_PATH = "/run/opengl-driver/lib";
          serviceConfig.DeviceAllow = [ "/dev/dxg rwm" ];
        };
      })
    ]
  );
}
