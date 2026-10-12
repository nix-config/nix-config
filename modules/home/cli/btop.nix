{
  lib,
  pkgs,
  opts,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  isAmd = (gpuType == "amd");
  isNvidia = (gpuType == "nvidia") || (gpuType == "nvidia-open");
in
{
  config = {
    programs.btop = lib.mkMerge [
      {
        enable = true;
        settings = {
          # 显示主题设置的背景色, false 为透明
          theme_background = false;
          # 更新间隔 (毫秒)
          update_ms = 1000;
        };
      }
      (lib.optionalAttrs isAmd {
        package = pkgs.btop-rocm;
      })
      (lib.optionalAttrs isNvidia {
        package = pkgs.btop-cuda;
      })
    ];
  };
}
