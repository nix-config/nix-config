{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.internet.wechat or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      # 这个版本有首次启动用不了输入法的问题
      # wechat
      wechat-uos
    ];
  };
}
