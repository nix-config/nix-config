{
  ...
}:
{
  config = {
    programs.zellij = {
      enable = true;
      # 是否在自动启动后附加到默认会话
      attachExistingSession = false;
      # 是否退出 Shell 时自动退出
      exitShellOnExit = false;
    };
  };
}
