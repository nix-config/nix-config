{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            ""
            # 使用 tuigreet 作为登录界面(基于终端的图形登录程序)
            + "${lib.getExe pkgs.tuigreet}"
            # 指定会话路径, 包含 xsessions 和 wayland-sessions 目录
            + " --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
            # 显示当前时间
            + " --time"
            # 时间格式
            + " --time-format '%Y-%m-%d %H:%M'"
            # 密码输入时显示星号
            + " --asterisks"
            # 记住用户名
            + " --remember"
            # 记住会话
            + " --remember-session";
        };
      };
    };
    # 确保 greetd 服务在 multi-user.target 之后启动
    # 避免在图形环境完全准备就绪前过早启动导致问题
    systemd.services.greetd = {
      after = [ "multi-user.target" ];
    };
  };
}
