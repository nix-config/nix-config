{
  ...
}:
{
  # 提供开发此仓库所需要的环境
  cli = {
    # 密钥管理工具
    sops.enable = true;
    # nix LSP 程序
    nixd.enable = true;
    # NixOS MCP
    mcp-nixos.enable = true;
    # nix 文件批量格式化工具
    nixfmt-tree.enable = true;
  };
}
