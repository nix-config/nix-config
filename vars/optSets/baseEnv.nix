{
  ...
}:
{
  # 提供使用此仓库所需要的环境
  cli = {
    # Nix CLI 助手, 自动清理旧一代系统配置
    nh.enable = true;
    # 分布式版本控制系统
    git.enable = true;
    # 命令运行器, 类似 Makefile
    just.enable = true;
  };
}
