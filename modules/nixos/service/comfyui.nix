{
  lib,
  pkgs,
  opts,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  inherit (opts.service.comfyui)
    extraArgs
    listen
    models
    port
    ;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
  package = pkgs.comfyui.override {
    python3 = pkgs.python3.override {
      packageOverrides = _final: prev: {
        # torch/triton/torchvision 换成预编译 CUDA wheel, 避免源码构建 CUDA torch
        torch = prev.torch-bin;
        triton = prev.triton-bin;
        torchvision = prev.torchvision-bin;
        # -bin 属性本身也固定, 保证包集内部 torch-bin 等解析一致
        torch-bin = prev.torch-bin;
        triton-bin = prev.triton-bin;
        torchvision-bin = prev.torchvision-bin;
      };
    };
  };
in
{
  config = lib.mkIf enableModule (
    lib.mkMerge [
      {
        services.comfyui = {
          enable = true;
          inherit package;
          inherit
            extraArgs
            listen
            models
            port
            ;
        };
      }
      (lib.optionalAttrs isWsl {
        systemd.services.comfyui = {
          environment.LD_LIBRARY_PATH = "/run/opengl-driver/lib";
          serviceConfig.DeviceAllow = [ "/dev/dxg rwm" ];
        };
      })
    ]
  );
}
