{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.btop or { };
  finallyEnable = cfg.enable or false;
  gpuType = opts.hardware.graphics.type or "";
in
{
  config = lib.mkIf finallyEnable {
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
      (lib.optionalAttrs (gpuType == "amd") {
        package = pkgs.btop-rocm;
      })
      (lib.optionalAttrs (gpuType == "nvidia") {
        package = pkgs.btop-cuda;
      })
    ];
  };
}
