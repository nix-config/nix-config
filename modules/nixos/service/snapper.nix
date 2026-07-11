{
  ...
}:
{
  config = {
    services.snapper.configs = {
      root = {
        # 文件系统类型
        FSTYPE = "btrfs";
        # 子卷或挂载点的路径
        SUBVOLUME = "/";
      };
      home = {
        FSTYPE = "btrfs";
        SUBVOLUME = "/home/";
      };
    };
  };
}
