{
  lib,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.terminal.foot.enable && (!desktopTypeIsNone);
  fishEnable = opts.shell.fish.enable;
in
{
  config = lib.mkIf enableModule {
    programs = {
      foot = {
        enable = true;
        settings = {
          colors-dark = {
            # 设置背景颜色
            background = "000000";
            # 设置背景透明度: 取值范围 0.0(完全透明)到 1.0(完全不透明)
            alpha = 0.75;
          };
          cursor = {
            # 光标形状: 可以将默认的方块(block)改成更细的竖线(beam)或下划线(underline)
            style = "beam";
          };
          mouse = {
            # 输入时立即隐藏鼠标
            hide-when-typing = "yes";
          };
          main = lib.mkMerge [
            {
              # DPI 感知
              dpi-aware = "yes";
            }
            (lib.optionalAttrs fishEnable {
              # 指定 shell
              shell = "fish";
            })
          ];
        };
      };
    };
  };
}
