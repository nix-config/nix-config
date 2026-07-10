{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.tool.lutris or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    programs.lutris = {
      enable = true;
      # 为 lutris 配合 umu-launcher 使用而添加的 proton 软件包列表
      protonPackages = with pkgs; [
        dwproton-bin
      ];
      extraPackages = with pkgs; [
        umu-launcher
      ];
    };
  };
}
