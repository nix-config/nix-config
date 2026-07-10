{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.tool.fcitx5 or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mellow-themes
          qt6Packages.fcitx5-chinese-addons
        ];
        waylandFrontend = true;
        settings = {
          # 全局配置
          globalOptions = {
            # 切换输入法
            "Hotkey/TriggerKeys" = {
              "0" = "Shift+Shift_L";
              "1" = "Shift+Shift_R";
            };
          };
          # 输入法配置
          inputMethod = {
            # 输入法组顺序
            GroupOrder."0" = "Default";
            # 定义组 "Default" 的详细配置
            "Groups/0" = {
              # 组名称
              Name = "Default";
              # 默认键盘布局
              "Default Layout" = "us";
              # 默认输入法为拼音
              DefaultIM = "pinyin";
            };
            # 组内第一个输入法项: 美式键盘
            "Groups/0/Items/0".Name = "keyboard-us";
            # 组内第二个输入法项: 拼音输入法
            "Groups/0/Items/1".Name = "pinyin";
          };
          addons = {
            classicui.globalSection = {
              # 垂直候选列表
              "Vertical Candidate List" = "False";
              # 使用鼠标滚轮翻页
              WheelForPaging = "True";
              # 字体
              Font = ''"Sans 10"'';
              # 菜单字体
              MenuFont = ''"Sans 10"'';
              # 托盘字体
              TrayFont = ''"Sans Bold 10"'';
              # 托盘标签轮廓颜色
              TrayOutlineColor = "#000000";
              # 托盘标签文本颜色
              TrayTextColor = "#ffffff";
              # 优先使用文字图标
              PreferTextIcon = "False";
              # 在图标中显示布局名称
              ShowLayoutNameInIcon = "True";
              # 使用输入法的语言来显示文字
              UseInputMethodLanguageToDisplayText = "True";
              # 主题
              Theme = "kwinblur-mellow-sakura";
              # 深色主题
              DarkTheme = "kwinblur-mellow-sakura-dark";
              # 跟随系统浅色/深色设置
              UseDarkTheme = "True";
              # 当被主题和桌面支持时使用系统的重点色
              UseAccentColor = "True";
              # 在 X11 上针对不同屏幕使用单独的 DPI
              PerScreenDPI = "False";
              # 固定 Wayland 的字体 DPI
              ForceWaylandDPI = 0;
              # 在 Wayland 下启用分数缩放
              EnableFractionalScale = "True";
            };
            pinyin = {
              globalSection = {
                # 每页候选词
                PageSize = 9;
                # 启用云拼音
                CloudPinyinEnabled = false;
              };
            };
            chttrans = {
              globalSection = {
                # 转换引擎
                Engine = "OpenCC";
                # 启用的输入法
                EnabledIM = "";
                # 简转繁的 OpenCC 配置
                OpenCCS2TProfile = "default";
                # 繁转简的 OpenCC 配置
                OpenCCT2SProfile = "default";
              };
              sections = {
                Hotkey = {
                  "0" = "Control+Shift+F";
                };
              };
            };
            punctuation = {
              globalSection = {
                # 字母或者数字之后输入半角标点
                HalfWidthPuncAfterLetterOrNumber = "True";
                # 同时输入成对标点 (例如引号)
                TypePairedPunctuationsTogether = "False";
                # Enabled
                Enabled = "True";
              };
              sections = {
                Hotkey = {
                  "0" = "Control+period";
                };
              };
            };
            notifications.globalSection = {
              # 隐藏通知
              HiddenNotifications = "";
            };
          };
        };
      };
    };
  };
}
