{
  lib,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.tool.clash-verge.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    programs.clash-verge = {
      enable = true;
      # 开机自动启动
      autoStart = true;
      # TUN 模式
      tunMode = true;
      # 系统代理模式
      serviceMode = true;
    };
  };
}
