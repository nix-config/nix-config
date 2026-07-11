{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = (opts.display.desktop.type == "hyprland");
  btopIsEnabled = opts.cli.btop.enable;
  yaziIsEnabled = opts.cli.yazi.enable;
  dmsIsEnabled = opts.display.dms.enable;
  footIsEnabled = opts.terminal.foot.enable;
  fcitx5IsEnabled = opts.tool.fcitx5.enable;
  kittyIsEnabled = opts.terminal.kitty.enable;
  udiskieIsEnabled = opts.service.udiskie.enable;
  missionCenterIsEnabled = opts.tool.mission-center.enable;
  toggle-monitor = pkgs.writeShellApplication {
    name = "toggle-monitor";
    runtimeInputs = [ pkgs.jq ]; # 依赖 jq 解析 JSON
    text =
      # 默认操作第 1 个显示器
      ''
        n="''${1:-1}"
      ''
      # 获取所有当前连接的显示器名称, 按字母排序以保证顺序稳定
      + ''
        mapfile -t names < <(hyprctl monitors all -j | jq -r ".[].name" | sort)
      ''
      # 计算目标索引 (bash 数组从 0 开始)
      + ''
        idx=$((n - 1))
        if [ -z "''${names[$idx]}" ]; then
            exit 1
        fi
        target="''${names[$idx]}"
      ''
      # 切换状态: 若当前启用则禁用, 否则启用
      + ''
        if hyprctl monitors | grep -qF "$target"; then
            hyprctl keyword monitor "$target",disable
        else
            hyprctl keyword monitor "$target",preferred,auto,1
        fi
      '';
  };
  numKeys = builtins.genList (
    i:
    let
      n = i + 1;
    in
    {
      key = if n == 10 then "0" else toString n;
      num = n;
    }
  ) 10;
in
{
  config = lib.mkIf enableModule {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "hyprlang";
      settings = {
        # ========== 显示器 ==========
        monitor = [
          # 格式: 名称, 分辨率, 位置, 缩放
          ", preferred, auto, 1"
        ];
        # ========== 变量 ==========
        # 终端模拟器
        "$terminal" =
          if kittyIsEnabled then
            "kitty"
          else if footIsEnabled then
            "foot"
          else
            "";
        # 系统活动监控器
        "$top" =
          if missionCenterIsEnabled then
            "missioncenter"
          else if btopIsEnabled then
            "$terminal -e btop"
          else
            "$terminal -e top";
        # 文件管理器
        "$fileManager" = if yaziIsEnabled then "$terminal -e yazi" else "";
        # 程序启动菜单
        "$menu" = if dmsIsEnabled then "dms ipc call spotlight toggle" else "";
        # 屏幕截图
        "$screenshot" = "dms screenshot";
        # 主修饰键
        "$mainMod" = "SUPER";
        # ========== 自启动 ==========
        exec-once =
          # DankMaterialShell
          lib.optional dmsIsEnabled "bash -lc 'exec dms run'"
          # 输入法
          ++ lib.optional fcitx5IsEnabled "fcitx5"
          # 自动挂载 U 盘
          ++ lib.optional udiskieIsEnabled "udiskie";
        # ========== 环境变量 ==========
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];
        # ========== 外观与视觉 ==========
        # 布局
        general = {
          # 窗口内边距
          gaps_in = 5;
          # 窗口外边距
          gaps_out = 10;
          # 窗口边框大小
          border_size = 2;
          # 活动窗口边框颜色
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          # 非活动窗口边框颜色
          "col.inactive_border" = "rgba(ffa5d2ee)";
          # 是否可以通过拖拽边框调整窗口大小
          resize_on_border = false;
          # 启用屏幕撕裂用于减少游戏中的延迟或抖动
          allow_tearing = false;
          # 窗口布局
          layout = "scrolling";
        };
        # 视觉效果
        decoration = {
          # 窗口圆角大小
          rounding = 10;
          rounding_power = 2;
          # 窗口透明度: 1.0 = 不透明, 0.0 = 完全透明
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          # 窗口阴影
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          # 模糊效果
          blur = {
            enabled = true;
            # 模糊半径
            size = 2;
            # 采样次数
            passes = 3;
            # 噪点纹理
            noise = 0.05;
            # 饱和度
            vibrancy = 0.1696;
          };
        };
        # 动画
        animations = {
          enabled = "yes, please :)";
          # 贝塞尔曲线定义
          bezier = [
            # 格式: 名称, X0, Y0, X1, Y1
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];
          # 动画定义
          animation = [
            # 格式: 名称, 开关, 速度, 曲线, [样式]
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
            "windowsOut,    1,     1.49,  linear,       popin 87%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    1,     1.94,  almostLinear, fade"
            "workspacesIn,  1,     1.21,  almostLinear, fade"
            "workspacesOut, 1,     1.94,  almostLinear, fade"
            "zoomFactor,    1,     7,     quick"
          ];
        };
        # 水平平铺布局
        dwindle = {
          # 伪平铺主开关, 开启后可按 mainMod + P 切换
          # pseudotile = true;
          # 保持分割状态, 建议开启
          preserve_split = true;
        };
        # 垂直平铺布局
        master = {
          new_status = "master";
        };
        # 杂项
        misc = {
          # 设置为 0 或 1 可禁用动漫吉祥物壁纸
          force_default_wallpaper = 1;
          # 如果设置为 true, 则禁用随机显示的 Hyprland 标志/动漫女孩背景
          disable_hyprland_logo = true;
        };
        # ========== 输入 ==========
        input = {
          # 键盘布局
          kb_layout = "us, cn";
          # 键盘变体
          kb_variant = "";
          # 键盘型号
          kb_model = "";
          # 键盘选项
          kb_options = "";
          # 键盘规则
          kb_rules = "";
          # 鼠标移动时焦点跟随: 0=禁用 1=仅输出 2=完全跟随
          follow_mouse = 1;
          # 鼠标灵敏度: -1.0 到 1.0, 0 表示不修改
          sensitivity = 0;
          # 触摸板设置
          touchpad = {
            # 自然滚动方向
            natural_scroll = true;
          };
        };
        # 手势配置: 三指水平滑动切换工作区
        # gesture = "3, horizontal, workspace";
        # 特定设备配置示例
        # device = [
        #   {
        #     name = "epic-mouse-v1";
        #     sensitivity = -0.5;
        #   }
        # ];
        # ========== 输快捷键绑定入 ==========
        bind = [
          # 打开终端
          "$mainMod, Q, exec, $terminal"
          # 打开系统活动监控器 (Super + T)
          "$mainMod, T, exec, $top"
          # 打开文件管理器 (Super + E)
          "$mainMod, E, exec, $fileManager"
          # 打开程序启动菜单 (Super + R)
          "$mainMod, R, exec, $menu"
          # 区域截图保存到剪贴板 (PrintScreen)
          ", Print, exec,  $screenshot region --no-file"
          # 区域截图保存到文件 (CTRL + PrintScreen)
          "CTRL, Print, exec, $screenshot region --dir ~/Pictures/Screenshots"
          # 关闭窗口 (Super + C)
          "$mainMod, C, killactive,"
          # 退出 Hyprland (Super + M)
          "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
          # 切换浮动窗口 (Super + V)
          "$mainMod, V, togglefloating,"
          # 伪平铺模式 (Super + P)
          # "$mainMod, P, pseudo,"
          # 切换分割 (Super + J)
          # "$mainMod, J, togglesplit,"
          # 移动焦点 (方向键)
          "$mainMod, left, layoutmsg, focus l"
          "$mainMod, right, layoutmsg, focus r"
          "$mainMod, up, layoutmsg, focus u"
          "$mainMod, down, layoutmsg, focus d"
          # 使用数字键切换工作区 (Super + 数字)
          (map (x: "$mainMod, ${x.key}, workspace, ${toString x.num}") numKeys)
          # 移动窗口到工作区 (Super + Shift + 数字)
          (map (x: "$mainMod SHIFT, ${x.key}, movetoworkspace, ${toString x.num}") numKeys)
          # 切换屏幕开关 (Super + ALT + 数字)
          (map (x: "$mainMod ALT, ${x.key}, exec, ${lib.getExe toggle-monitor} ${toString x.num}") numKeys)
          # 特殊工作区 (便签本)
          # 切换 (Super + S)
          # "$mainMod, S, togglespecialworkspace, magic"
          # 移入 (Super + Shift + S)
          # $mainMod SHIFT, S, movetoworkspace, special:magic
          # 使用鼠标滚轮在垂直方向滚动工作区 (Super + 滚轮)
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          # 增加当前窗口列宽度 10% (Super + +)
          "$mainMod, equal, layoutmsg, colresize +0.1"
          # 减小当前窗口列宽度 10% (Super + -)
          "$mainMod, minus, layoutmsg, colresize -0.1"
          # 将当前列与左侧邻居交换 (Super + CTRL + ←)
          "$mainMod CTRL, left, layoutmsg, swapcol l"
          # 将当前列与右侧邻居交换 (Super + CTRL + →)
          "$mainMod CTRL, right, layoutmsg, swapcol r"
        ];
        bindm = [
          # 鼠标拖拽移动/调整窗口大小: Super + 左键/右键拖拽
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        bindel = [
          # 笔记本电脑多媒体键: 音量调节
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          # 屏幕亮度调节
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];
        bindl = [
          # 播放器控制 (需要 playerctl)
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
        # ========== 窗口和工作区 ==========
        windowrule = [
          {
            # 忽略所有应用的最大化请求
            name = "suppress-maximize-events";
            match = {
              class = ".*";
            };
            suppress_event = "maximize";
          }
          {
            # 修复 XWayland 拖拽问题
            name = "fix-xwayland-drags";
            match = {
              class = "^$";
              title = "^$";
              xwayland = true;
              float = true;
              fullscreen = false;
              pin = false;
            };
            no_focus = true;
          }
          {
            # Hyprland-run 启动器窗口规则
            name = "move-hyprland-run";
            match = {
              class = "hyprland-run";
            };
            move = "20 monitor_h-120";
            float = true;
          }
        ];
      };
    };
  };
}
