{
  ...
}:
{
  # 提供一个开箱即用的 fish shell
  cli = {
    # cat 替代品, 带语法高亮和行号
    bat.enable = true;
    # ls 替代品, 现代文件列表工具
    eza.enable = true;
    # 命令行模糊搜索工具
    fzf.enable = true;
    # 用 Rust 编写的快速文件管理器
    yazi.enable = true;
    # 系统资源监控器
    btop.enable = true;
    # 跨 Shell 的提示符定制工具
    starship.enable = true;
    # 类似 Neofetch 但更快的系统信息工具
    fastfetch.enable = true;
  };
  shell = {
    # 用户友好的命令解释器
    fish.enable = true;
  };
}
