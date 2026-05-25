{
  lib,
  opts,
  ...
}:
let
  cfg = opts.terminal.kitty or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
  fishEnable = opts.shell.fish.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      kitty = {
        enable = true;
        settings = {
          # 设置背景颜色
          background = "#000000";
          # 设置背景透明度: 取值范围 0.0(完全透明)到 1.0(完全不透明)
          background_opacity = 0.75;
          # 光标形状: 可以将默认的方块(block)改成更细的竖线(beam)或下划线(underline)
          cursor_shape = "beam";
          # 光标跳转动画: 光标移动时产生渐变拖尾效果 (数值为拖尾长度)
          cursor_trail = 3;
          # 触发拖尾的最小移动距离 (单位: 单元格)
          cursor_trail_start_threshold = 2;
          # 输入时立即隐藏鼠标
          mouse_hide_wait = -1.0;
        }
        // lib.optionalAttrs fishEnable {
          # 指定 shell
          shell = "fish";
        };
      };
    };
  };
}
