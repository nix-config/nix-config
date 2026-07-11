{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.service.libinput.enable;
in
{
  config = lib.mkIf enableModule {
    services = {
      # 启用输入设备支持(在大多数桌面管理器中默认启用)
      libinput.enable = true;
    };
  };
}
