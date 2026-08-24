{
  lib,
  opts,
  ...
}:
let
  enableModule =
    (lib.elem "noctalia" opts.display.widget.enabledWidgets) && opts.display.desktop.enable;
in
{
  config = lib.mkIf enableModule {
    programs.noctalia = {
      enable = true;
      # 启用 NetworkManager, 蓝牙, UPower 和电源配置服务
      recommendedServices.enable = true;
    };
  };
}
