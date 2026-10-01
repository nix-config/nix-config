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
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mellow-themes
          qt6Packages.fcitx5-chinese-addons
        ];
        waylandFrontend = true;
        # 只写与 fcitx5 内置默认值不同的项
        # 未写的键由 fcitx5 用自己的默认值
        settings = {
          # 全局配置
          "globalOptions" = {
            # 切换输入法
            "Hotkey/TriggerKeys" = {
              "0" = "Shift+Shift_L";
              "1" = "Shift+Shift_R";
            };
          };
          # 输入法配置
          "inputMethod" = {
            # 输入法组顺序
            "GroupOrder"."0" = "Default";
            # 定义组 "Default" 的详细配置
            "Groups/0" = {
              # 组名称
              "Name" = "Default";
              # 默认键盘布局
              "Default Layout" = "us";
              # 默认输入法为拼音
              "DefaultIM" = "pinyin";
            };
            # 组内第一个输入法项: 美式键盘
            "Groups/0/Items/0"."Name" = "keyboard-us";
            # 组内第二个输入法项: 拼音输入法
            "Groups/0/Items/1"."Name" = "pinyin";
          };
          "addons" = {
            # 每页候选词
            "pinyin"."globalSection"."PageSize" = 9;
            # 主题
            "classicui"."globalSection" = {
              "Theme" = "mellow-sakura";
              "DarkTheme" = "mellow-sakura-dark";
              "UseDarkTheme" = "True";
            };
          };
        };
      };
    };
  };
}
