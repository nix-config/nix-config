{
  ...
}:
{
  config = {
    security.polkit = {
      enable = true;
      # 提供 setuid 的 pkexec wrapper
      # 无 TTY 的 GUI 场景依赖它弹出 Polkit 认证对话框
      enablePkexecWrapper = true;
    };
  };
}
