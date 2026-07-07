inputs:
let
  inherit (inputs.nixpkgs) lib;
  inherit (lib) types;
  inherit (types) int;
  inherit (types) str;
  inherit (types) bool;
  inherit (types) enum;
  inherit (types) attrs;
  listOfStr = types.listOf str;
  attrsOfStr = types.attrsOf str;
  listOfAttrs = types.listOf attrs;
  systems = lib.systems.flakeExposed;
in
{
  # 输出数量
  count = int;
  # 输出平台
  system = enum systems;
  # 初始状态版本
  stateVersion = str;
  # nix-config 仓库路径
  nixConfigPath = str;
  # 命令行工具
  cli = {
    # 在 NixOS 上运行未打补丁的动态二进制文件
    nix-ld.enable = bool;
    # Nix 包管理器配置
    nix = {
      enable = bool;
      substituters = listOfStr;
      trusted-public-keys = listOfStr;
    };
    # 基于 Rust 的更安全的 sudo
    sudo-rs.enable = bool;
    # cat 替代品, 带语法高亮和行号
    bat.enable = bool;
    # 系统资源监控器
    btop.enable = bool;
    # 环境变量管理工具
    direnv.enable = bool;
    # ls 替代品, 现代文件列表工具
    eza.enable = bool;
    # 类似 Neofetch 但更快的系统信息工具
    fastfetch.enable = bool;
    # 命令行模糊搜索工具
    fzf.enable = bool;
    # 分布式版本控制系统
    git = {
      enable = bool;
      user = {
        name = str;
        email = str;
      };
    };
    # 命令运行器, 类似 Makefile
    just.enable = bool;
    # NixOS MCP
    mcp-nixos.enable = bool;
    # Nix CLI 助手, 自动清理旧一代系统配置
    nh.enable = bool;
    # nix LSP 程序
    nixd.enable = bool;
    # nix 文件批量格式化工具
    nixfmt-tree.enable = bool;
    # NVIDIA GPU 监控工具
    nvitop.enable = bool;
    # AI 编程助手
    opencode.enable = bool;
    # 密钥管理工具
    sops.enable = bool;
    # 安全远程登录客户端
    ssh = {
      enable = bool;
      # 需要解密的 ssh 密钥名称列表
      enableSshSecrets = listOfStr;
    };
    # 跨 Shell 的提示符定制工具
    starship.enable = bool;
    # 终端复用器, 可在一个终端中运行多个会话
    tmux.enable = bool;
    # 用 Rust 编写的快速文件管理器
    yazi.enable = bool;
    # 基于 Rust 的新一代终端复用器
    zellij.enable = bool;
  };
  # 实用工具
  tool = {
    # Clash 代理客户端
    clash-verge.enable = bool;
    # 模块化输入法框架, 支持多种输入法
    fcitx5.enable = bool;
    # Linux 游戏平台管理工具
    lutris.enable = bool;
    # GUI 系统活动监控器
    mission-center.enable = bool;
    # 办公套件
    onlyoffice.enable = bool;
    # 游戏逆向工程工具 (Linux 版 Cheat Engine)
    pince.enable = bool;
  };
  # 本地化和语言
  i18n.locale = enum [
    "en-us"
    "zh-cn"
  ];
  # 媒体应用
  media = {
    # 轻量级视频播放器
    mpv.enable = bool;
    # 录屏和直播软件
    obs-studio.enable = bool;
    # Spotify 音乐播放器
    spotify.enable = bool;
  };
  # 命令解释器
  shell = {
    # 通用的命令解释器
    bash.enable = bool;
    # 用户友好的命令解释器
    fish.enable = bool;
  };
  # 编辑器
  editor = {
    # Neovim 的 Nix 配置
    nixvim.enable = bool;
    # Visual Studio Code
    vscode = {
      enable = bool;
      # 扩展开关, 其中 all 为全部开启
      extensions = {
        all.enable = bool;
        base.enable = bool;
        go.enable = bool;
        javascript.enable = bool;
        markdown.enable = bool;
        nix.enable = bool;
        python.enable = bool;
        reader.enable = bool;
        remote.enable = bool;
        rust.enable = bool;
      };
    };
  };
  # 桌面环境
  desktop = {
    # 桌面类型
    type = enum [
      "wsl"
      "none"
      "hyprland"
    ];
    # DankMaterialShell
    dms.enable = bool;
  };
  # 系统服务
  service = {
    # ComfyUI Web 服务
    comfyui.enable = bool;
    # 内核级透明代理
    daed.enable = bool;
    # 内网穿透工具
    frp = {
      enable = bool;
      role = enum [
        "server"
        "client"
      ];
      proxies = listOfAttrs;
    };
    # 轻量级登录管理器
    greetd.enable = bool;
    hermes-agent.enable = bool;
    # 输入设备驱动服务
    libinput.enable = bool;
    # 系统登录和电源管理
    logind.enable = bool;
    # HTTP 和反向代理 web 服务器
    nginx.enable = bool;
    ollama.enable = bool;
    # 支持多种存储的文件列表程序
    openlist.enable = bool;
    # SSH 服务器
    openssh.enable = bool;
    # 多媒体框架, 替代 PulseAudio
    pipewire.enable = bool;
    # 远程桌面服务器
    rustdesk-server = {
      enable = bool;
      # 中继地址
      relayHosts = listOfStr;
    };
    # 搜索服务
    searxng = {
      enable = bool;
      firewall = attrs;
    };
    # 通用代理工具
    sing-box.enable = bool;
    # Btrfs 快照管理工具
    snapper.enable = bool;
    # Sops Nix 服务
    sops-nix.enable = bool;
    # U 盘自动挂载服务
    udiskie.enable = bool;
    # P2P VPN 服务
    zerotierone = {
      enable = bool;
      # 加入的网络
      joinNetworks = listOfStr;
    };
  };
  # 硬件配置
  hardware = {
    # 内存压缩配置
    zram.enable = bool;
    # 蓝牙配置
    bluetooth.enable = bool;
    # 图形驱动配置
    graphics = {
      type = enum [
        "none"
        "amd"
        "nvidia"
      ];
    };
    # 内核配置
    kernel = {
      # 类型
      types = listOfStr;
      # 额外参数
      configs = attrsOfStr;
    };
    # 网络配置
    networking = attrs;
    # 磁盘配置, 具体定义查看: vars/diskPartitionTypes/
    disk = attrs;
    boot-loader = {
      # 启动加载器
      type = enum [
        "wsl"
        "grub"
        "systemd-boot"
      ];
      # EFI 系统分区挂载点
      efiSysMountPoint = str;
    };
  };
  # 网络应用
  internet = {
    # 火狐浏览器
    firefox.enable = bool;
    # 腾讯 QQ
    qq.enable = bool;
    # 远程桌面客户端
    rustdesk.enable = bool;
    # 即时通讯应用
    telegram-desktop.enable = bool;
    # 微信
    wechat.enable = bool;
  };
  # 终端模拟器
  terminal = {
    # 轻量级终端模拟器
    foot.enable = bool;
    # 跨平台 GPU 加速终端模拟器
    kitty.enable = bool;
  };
  # 容器管理
  container = {
    enable = bool;
    # 容器运行时类型
    type = enum [
      "podman"
      "docker"
    ];
    # Arch 开发容器
    dev-arch.enable = bool;
    # Portainer 代理
    portainer-agent.enable = bool;
  };
}
