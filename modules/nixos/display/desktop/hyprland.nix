{
  lib,
  opts,
  ...
}:
let
  enableModule = (opts.display.desktop.type == "hyprland");
in
{
  config = lib.mkIf enableModule {
    programs.hyprland = {
      enable = true;
      # UWSM 支持
      withUWSM = true;
      # XWayland 支持, 允许运行 X11 应用
      xwayland.enable = true;
    };
  };
}
