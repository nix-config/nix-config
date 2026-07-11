{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      # 这个版本有首次启动用不了输入法的问题
      # wechat
      wechat-uos
    ];
  };
}
