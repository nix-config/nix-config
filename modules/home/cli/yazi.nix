{
  ...
}:
{
  config = {
    programs.yazi = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = true;
      settings.mgr = {
        # 每行右侧显示的元信息
        linemode = "owner";
        # 显示以 . 开头的隐藏文件
        show_hidden = true;
      };
    };
  };
}
