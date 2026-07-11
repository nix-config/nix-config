{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
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
