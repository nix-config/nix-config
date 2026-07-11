{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.tool.lutris.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
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
