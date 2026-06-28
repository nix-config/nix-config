{
  lib,
  opts,
  ...
}:
let
  cfg = opts.tool.clash-verge or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
in
{
  config = lib.mkIf finallyEnable {
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
