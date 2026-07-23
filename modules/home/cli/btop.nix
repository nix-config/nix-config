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
          # 是否显示主题设置的背景色, 若希望终端背景透明请设为 false
          theme_background = false;
          # 更新间隔 (毫秒)
          update_ms = 1000;
          # 进程排序方式
          proc_sorting = "cpu direct";
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
