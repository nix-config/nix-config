{
  ...
}:
{
  config = {
    security.sudo-rs = {
      enable = true;
      # 只允许 wheel 组成员可执行 sudo
      execWheelOnly = true;
    };
  };
}
