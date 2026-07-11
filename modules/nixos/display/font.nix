{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsWsl = (opts.display.desktopType == "wsl");
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = (!desktopTypeIsNone) && (!desktopTypeIsWsl);
in
{
  config = lib.mkIf enableModule {
    # 字体配置
    fonts = {
      # 默认字体集(禁用)
      enableDefaultPackages = false;
      # 安装字体
      packages = with pkgs; [
        # Nerd 字体
        nerd-fonts.fira-code
        # 谷歌开源免费字体
        noto-fonts
        # 无衬线字体
        noto-fonts-cjk-sans
        # 衬线字体
        noto-fonts-cjk-serif
        # 彩色表情符号字体
        noto-fonts-color-emoji
      ];
      # 配置字体
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [
            "FiraCode Nerd Font"
          ];
          serif = [
            "Noto Serif CJK SC"
          ];
          sansSerif = [
            "Noto Sans CJK SC"
          ];
          emoji = [
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
