{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
  # TODO: fcitx/fcitx5#1668, 随 fcitx 5.1.23 发布后可移除
  fcitx5 = pkgs.fcitx5.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (pkgs.fetchpatch {
        name = "fcitx5-1668-load-svg-as-cairo-pattern.patch";
        url = "https://github.com/fcitx/fcitx5/commit/41d6d98dbbc38f351f9707bc99ee3c59941193f0.patch";
        hash = "sha256-osBaEk+I8gixvFk8p5HEzY3QgO2dgvjHKljUacDbO0o=";
      })
    ];
  });
in
{
  config = lib.mkIf enableModule {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        fcitx5-with-addons = pkgs.qt6Packages.fcitx5-with-addons.override {
          inherit fcitx5;
        };
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
