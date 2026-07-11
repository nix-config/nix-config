{
  ...
}:
{
  config = {
    services = {
      # 合盖管理
      # ignore: 忽略合盖事件
      # suspend: 合盖时挂起
      # lock: 合盖时锁定屏幕
      # poweroff: 合盖时关机
      logind.settings.Login = {
        # 接通电源时合盖
        HandleLidSwitchExternalPower = "ignore";
        # 连接显示器(docked)时合盖
        HandleLidSwitchDocked = "ignore";
        # 电池供电时合盖
        HandleLidSwitch = "ignore";
      };
    };
  };
}
