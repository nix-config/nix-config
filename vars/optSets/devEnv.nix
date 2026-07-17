{
  ...
}:
{
  # 提供开发此仓库所需要的环境
  cli = {
    sops.enable = true;
    nixd.enable = true;
    nixfmt-tree.enable = true;
  };
}
