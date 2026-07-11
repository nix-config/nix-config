{
  ...
}:
{
  config = {
    # NH 程序配置
    programs.nh = {
      # 启用 NH 程序
      enable = true;
      clean = {
        # 启用清理
        enable = true;
        # 清理操作的执行频率
        dates = "weekly";
        # 清理参数
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
  };
}
