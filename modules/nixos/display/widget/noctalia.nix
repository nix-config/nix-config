{
  lib,
  opts,
  inputs,
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
      # TODO
      package = inputs.noctalia.packages.x86_64-linux.default;
      # 启用 NetworkManager, 蓝牙, UPower 和电源配置服务
      recommendedServices.enable = true;
    };
  };
}
