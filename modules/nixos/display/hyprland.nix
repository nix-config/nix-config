{
  lib,
  opts,
  ...
}:
let
  cfg = opts.display or { };
  finallyEnable = (opts.display.desktopType or "none") == "hyprland";
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      # Wayland 合成器/桌面环境
      hyprland = {
        # 启用 Hyprland Wayland 合成器
        enable = true;
        # 启用 XWayland 支持, 允许运行 X11 应用
        xwayland.enable = true;
        # 启用 UWSM 支持, 允许运行 Wayland 应用
        withUWSM = true;
      };
    };
  };
}
