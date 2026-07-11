{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.hardware.zram.enable;
in
{
  config = lib.mkIf enableModule {
    zramSwap = {
      # 启用内存压缩设备和由 zram 内核模块提供的交换空间
      enable = true;
      # zram 交换设备的优先级
      priority = 5;
      # lzo 算法
      algorithm = "zstd";
      # zram 交换设备可存储的最大内存总量(占总内存的百分比)
      memoryPercent = 50;
    };
  };
}
