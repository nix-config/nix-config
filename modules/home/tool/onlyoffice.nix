{
  lib,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.tool.onlyoffice.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    programs.onlyoffice = {
      enable = true;
      settings = {
        # 颜色主题
        UITheme = "theme-white";
        # 文件打开于新窗口
        editorWindowMode = false;
        # 从右向左的文字排版
        forcedRtl = false;
        # 应用启动时窗口处于最大化状态
        maximized = false;
        # 标题栏
        titlebar = "custom";
      };
    };
  };
}
