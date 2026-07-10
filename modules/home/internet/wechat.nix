{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.internet.wechat or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
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
