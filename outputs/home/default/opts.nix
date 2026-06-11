{
  vars,
  optSets,
  ...
}:
let
  user = {
    # 预定义选项集列表
    predefinedOptSetsList = with optSets; [
      # 提供使用此仓库所需要的环境
      baseEnv
      # 提供一个开箱即用的 fish shell
      fishShell
    ];
    # 自定义选项集
    customOptSets = {
      # 输出数量
      count = 1;
      # 初始状态版本
      stateVersion = "26.05";
      # 输出平台
      system = vars.systemTypes.x86_64-linux;
      # nix-config 仓库路径
      nixConfigPath = "path/to/nix-config";
      # ========== 命令行工具 ==========
      cli = {
        # Nix CLI 助手, 自动清理旧一代系统配置
        # nh.enable = true;
        # cat 替代品, 带语法高亮和行号
        # bat.enable = true;
        # ls 替代品, 现代文件列表工具
        # eza.enable = true;
        # 命令行模糊搜索工具
        # fzf.enable = true;
        # 安全远程登录客户端
        ssh.enable = false;
        # 命令运行器, 类似 Makefile
        # just.enable = true;
        # 密钥管理工具
        sops.enable = false;
        # nix LSP 程序
        nixd.enable = false;
        # 终端复用器, 可在一个终端中运行多个会话
        tmux.enable = false;
        # 用 Rust 编写的快速文件管理器
        # yazi.enable = true;
        # 系统资源监控器
        # btop.enable = true;
        # 环境变量管理工具
        direnv.enable = false;
        # 基于 Rust 的新一代终端复用器
        zellij.enable = false;
        # NVIDIA GPU 监控工具
        nvitop.enable = false;
        # 跨 Shell 的提示符定制工具
        # starship.enable = true;
        # AI 编程助手
        opencode.enable = false;
        # 类似 Neofetch 但更快的系统信息工具
        # fastfetch.enable = true;
        # NixOS MCP
        mcp-nixos.enable = false;
        # nix 文件批量格式化工具
        # nixfmt-tree.enable = false;
        # 分布式版本控制系统
        # git = {
        #   enable = true;
        #   user = {
        #     name = "";
        #     email = "";
        #   };
        # };
      };
      # ========== 实用工具 ==========
      tool = {
        # 模块化输入法框架, 支持多种输入法
        fcitx5.enable = false;
        # 游戏逆向工程工具 (Linux 版 Cheat Engine)
        pince.enable = false;
        # Linux 游戏平台管理工具
        lutris.enable = false;
        # 办公套件
        onlyoffice.enable = false;
        # GUI 系统活动监控器
        mission-center.enable = false;
      };
      # ========== 本地化和语言 ==========
      i18n = {
        # 语言环境, 可选项:
        # en-us
        # zh-cn
        locale = vars.localeTypes.en-us;
      };
      # ========== 媒体应用 ==========
      media = {
        # 轻量级视频播放器
        mpv.enable = false;
        # Spotify 音乐播放器
        spotify.enable = false;
        # 录屏和直播软件
        obs-studio.enable = false;
      };
      # ========== 命令解释器 ==========
      shell = {
        # 通用的命令解释器
        bash.enable = false;
        # 用户友好的命令解释器
        # fish.enable = true;
      };
      # ========== 编辑器 ==========
      editor = {
        # Neovim 的 Nix 配置
        nixvim.enable = false;
        # Visual Studio Code
        vscode.enable = false;
      };
      # ========== 终端模拟器 ==========
      terminal = {
        # 轻量级终端模拟器
        foot.enable = false;
        # 跨平台 GPU 加速终端模拟器
        kitty.enable = false;
      };
      # ========== 系统服务 ==========
      service = {
        # Sops Nix 服务
        sops-nix.enable = false;
      };
      # ========== 网络应用 ==========
      internet = {
        # 腾讯 QQ
        qq.enable = false;
        # 微信
        wechat.enable = false;
        # 火狐浏览器
        firefox.enable = false;
        # 远程桌面客户端
        rustdesk.enable = false;
        # 即时通讯应用
        telegram-desktop.enable = false;
      };
      # ========== 硬件配置 ==========
      hardware = {
        # 图形驱动配置
        graphics = {
          # GPU 类型, 可选项:
          # none (默认)
          # amd
          # nvidia
          type = vars.gpuTypes.none;
        };
      };
    };
  };
in
{
  inherit user;
}
