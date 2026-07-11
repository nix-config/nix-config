{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.hardware.bluetooth.enable;
in
{
  config = lib.mkIf enableModule {
    hardware.bluetooth = {
      enable = true;
      # 是否在启动时启用默认的蓝牙控制器
      powerOnBoot = false;
    };
  };
}
