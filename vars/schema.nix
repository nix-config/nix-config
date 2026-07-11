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
  count = {
    type = int;
    default = 1;
  };
  # 输出平台
  system = {
    type = enum systems;
    default = "x86_64-linux";
  };
  # 初始状态版本
  stateVersion = {
    type = str;
    default = "26.05";
  };
  # nix-config 仓库路径
  nixConfigPath = {
    type = str;
    default = "";
  };
  # 命令行工具
  cli = {
    # 在 NixOS 上运行未打补丁的动态二进制文件
    nix-ld.enable = {
      type = bool;
      default = false;
    };
    # Nix 包管理器配置
    nix = {
      enable = {
        type = bool;
        default = false;
      };
      substituters = {
        type = listOfStr;
        default = [ ];
      };
      trusted-public-keys = {
        type = listOfStr;
        default = [ ];
      };
      trusted-substituters = {
        type = listOfStr;
        default = [ ];
      };
    };
    # 基于 Rust 的更安全的 sudo
    sudo-rs.enable = {
      type = bool;
      default = false;
    };
    # cat 替代品, 带语法高亮和行号
    bat.enable = {
      type = bool;
      default = false;
    };
    # 系统资源监控器
    btop.enable = {
      type = bool;
      default = false;
    };
    # 环境变量管理工具
    direnv.enable = {
      type = bool;
      default = false;
    };
    # ls 替代品, 现代文件列表工具
    eza.enable = {
      type = bool;
      default = false;
    };
    # 类似 Neofetch 但更快的系统信息工具
    fastfetch.enable = {
      type = bool;
      default = false;
    };
    # 命令行模糊搜索工具
    fzf.enable = {
      type = bool;
      default = false;
    };
    # 分布式版本控制系统
    git = {
      enable = {
        type = bool;
        default = false;
      };
      user = {
        name = {
          type = str;
          default = "";
        };
        email = {
          type = str;
          default = "";
        };
      };
    };
    # 命令运行器, 类似 Makefile
    just.enable = {
      type = bool;
      default = false;
    };
    # NixOS MCP
    mcp-nixos.enable = {
      type = bool;
      default = false;
    };
    # Nix CLI 助手, 自动清理旧一代系统配置
    nh.enable = {
      type = bool;
      default = false;
    };
    # nix LSP 程序
    nixd.enable = {
      type = bool;
      default = false;
    };
    # nix 文件批量格式化工具
    nixfmt-tree.enable = {
      type = bool;
      default = false;
    };
    # NVIDIA GPU 监控工具
    nvitop.enable = {
      type = bool;
      default = false;
    };
    # AI 编程助手
    opencode.enable = {
      type = bool;
      default = false;
    };
    # 密钥管理工具
    sops.enable = {
      type = bool;
      default = false;
    };
    # 安全远程登录客户端
    ssh = {
      enable = {
        type = bool;
        default = false;
      };
      # 需要解密的 ssh 密钥名称列表
      enableSshSecrets = {
        type = listOfStr;
        default = [ ];
      };
    };
    # 跨 Shell 的提示符定制工具
    starship.enable = {
      type = bool;
      default = false;
    };
    # 终端复用器, 可在一个终端中运行多个会话
    tmux.enable = {
      type = bool;
      default = false;
    };
    # 用 Rust 编写的快速文件管理器
    yazi.enable = {
      type = bool;
      default = false;
    };
    # 基于 Rust 的新一代终端复用器
    zellij.enable = {
      type = bool;
      default = false;
    };
    # 代码库记忆 MCP 服务
    codebase-memory-mcp.enable = {
      type = bool;
      default = false;
    };
  };
  # 实用工具
  tool = {
    # Clash 代理客户端
    clash-verge.enable = {
      type = bool;
      default = false;
    };
    # 模块化输入法框架, 支持多种输入法
    fcitx5.enable = {
      type = bool;
      default = false;
    };
    # Linux 游戏平台管理工具
    lutris.enable = {
      type = bool;
      default = false;
    };
    # GUI 系统活动监控器
    mission-center.enable = {
      type = bool;
      default = false;
    };
    # 办公套件
    onlyoffice.enable = {
      type = bool;
      default = false;
    };
    # 游戏逆向工程工具 (Linux 版 Cheat Engine)
    pince.enable = {
      type = bool;
      default = false;
    };
  };
  # 媒体应用
  media = {
    # 轻量级视频播放器
    mpv.enable = {
      type = bool;
      default = false;
    };
    # 录屏和直播软件
    obs-studio.enable = {
      type = bool;
      default = false;
    };
    # Spotify 音乐播放器
    spotify.enable = {
      type = bool;
      default = false;
    };
  };
  # 命令解释器
  shell = {
    # 通用的命令解释器
    bash.enable = {
      type = bool;
      default = false;
    };
    # 用户友好的命令解释器
    fish.enable = {
      type = bool;
      default = false;
    };
  };
  # 编辑器
  editor = {
    # Neovim 的 Nix 配置
    nixvim.enable = {
      type = bool;
      default = false;
    };
    # Visual Studio Code
    vscode = {
      enable = {
        type = bool;
        default = false;
      };
      # 扩展开关, 其中 all 为全部开启
      extensions = {
        all.enable = {
          type = bool;
          default = false;
        };
        base.enable = {
          type = bool;
          default = false;
        };
        go.enable = {
          type = bool;
          default = false;
        };
        javascript.enable = {
          type = bool;
          default = false;
        };
        markdown.enable = {
          type = bool;
          default = false;
        };
        nix.enable = {
          type = bool;
          default = false;
        };
        python.enable = {
          type = bool;
          default = false;
        };
        reader.enable = {
          type = bool;
          default = false;
        };
        remote.enable = {
          type = bool;
          default = false;
        };
        rust.enable = {
          type = bool;
          default = false;
        };
      };
    };
  };
  # 桌面环境
  display = {
    # 桌面环境
    desktop = {
      enable = {
        type = bool;
        default = false;
      };
      type = {
        type = enum [
          "wsl"
          "none"
          "hyprland"
        ];
        default = "none";
      };
    };
    # 字体配置
    font.enable = {
      type = bool;
      default = false;
    };
    # GTK 配置
    gtk.enable = {
      type = bool;
      default = false;
    };
    # DankMaterialShell
    dms.enable = {
      type = bool;
      default = false;
    };
  };
  # 系统服务
  service = {
    # ComfyUI Web 服务
    comfyui.enable = {
      type = bool;
      default = false;
    };
    # 内核级透明代理
    daed.enable = {
      type = bool;
      default = false;
    };
    # 内网穿透工具
    frp = {
      enable = {
        type = bool;
        default = false;
      };
      role = {
        type = enum [
          "server"
          "client"
        ];
        default = "server";
      };
      proxies = {
        type = listOfAttrs;
        default = [ ];
      };
    };
    # 轻量级登录管理器
    greetd.enable = {
      type = bool;
      default = false;
    };
    hermes-agent.enable = {
      type = bool;
      default = false;
    };
    # 输入设备驱动服务
    libinput.enable = {
      type = bool;
      default = false;
    };
    # 系统登录和电源管理
    logind.enable = {
      type = bool;
      default = false;
    };
    # HTTP 和反向代理 web 服务器
    nginx.enable = {
      type = bool;
      default = false;
    };
    ollama.enable = {
      type = bool;
      default = false;
    };
    # llama.cpp 推理服务
    llama-cpp = {
      enable = {
        type = bool;
        default = false;
      };
      # 额外设置
      extraSettings = {
        type = attrs;
        default = { };
      };
    };
    # 支持多种存储的文件列表程序
    openlist.enable = {
      type = bool;
      default = false;
    };
    # SSH 服务器
    openssh.enable = {
      type = bool;
      default = false;
    };
    # 多媒体框架, 替代 PulseAudio
    pipewire.enable = {
      type = bool;
      default = false;
    };
    # 远程桌面服务器
    rustdesk-server = {
      enable = {
        type = bool;
        default = false;
      };
      # 中继地址
      relayHosts = {
        type = listOfStr;
        default = [ ];
      };
    };
    # 搜索服务
    searxng = {
      enable = {
        type = bool;
        default = false;
      };
      firewall = {
        type = attrs;
        default = { };
      };
    };
    # 通用代理工具
    sing-box.enable = {
      type = bool;
      default = false;
    };
    # Btrfs 快照管理工具
    snapper.enable = {
      type = bool;
      default = false;
    };
    # Sops Nix 服务
    sops-nix.enable = {
      type = bool;
      default = false;
    };
    # U 盘自动挂载服务
    udiskie.enable = {
      type = bool;
      default = false;
    };
    # P2P VPN 服务
    zerotierone = {
      enable = {
        type = bool;
        default = false;
      };
      # 加入的网络
      joinNetworks = {
        type = listOfStr;
        default = [ ];
      };
    };
    # 容器管理
    container = {
      enable = {
        type = bool;
        default = false;
      };
      # 容器运行时类型
      type = {
        type = enum [
          "podman"
          "docker"
        ];
        default = "podman";
      };
      # Arch 开发容器
      dev-arch.enable = {
        type = bool;
        default = false;
      };
      # Portainer 代理
      portainer-agent.enable = {
        type = bool;
        default = false;
      };
    };
  };
  # 硬件配置
  hardware = {
    # 内存压缩配置
    zram.enable = {
      type = bool;
      default = false;
    };
    # 蓝牙配置
    bluetooth.enable = {
      type = bool;
      default = false;
    };
    # 图形驱动配置
    graphics = {
      type = {
        type = enum [
          "none"
          "amd"
          "nvidia"
        ];
        default = "none";
      };
    };
    # 内核配置
    kernel = {
      enable = {
        # 类型
        type = bool;
        default = false;
      };
      types = {
        type = listOfStr;
        default = [ ];
      };
      # 额外参数
      configs = {
        type = attrsOfStr;
        default = { };
      };
    };
    # 网络配置
    networking = {
      # 是否启用网络配置
      enable = {
        type = bool;
        default = false;
      };
      # 主机名
      hostName = {
        type = str;
        default = "nixos";
      };
      # 代理配置
      proxy = {
        type = attrs;
        default = { };
      };
      # 防火墙配置
      firewall = {
        type = attrs;
        default = {
          enable = false;
        };
      };
      # 网络管理器配置
      networkmanager = {
        type = attrs;
        default = {
          enable = false;
        };
      };
    };
    # 磁盘配置, 具体定义查看: vars/diskPartitionTypes/
    disk = {
      enable = {
        type = bool;
        default = false;
      };
      devices = {
        type = attrs;
        default = { };
      };
    };
    boot-loader = {
      enable = {
        type = bool;
        default = false;
      };
      type = {
        type = enum [
          "wsl"
          "grub"
          "systemd-boot"
        ];
        default = "systemd-boot";
      };
      # EFI 系统分区挂载点
      efiSysMountPoint = {
        type = str;
        default = "/boot";
      };
    };
  };
  # 网络应用
  internet = {
    # 火狐浏览器
    firefox.enable = {
      type = bool;
      default = false;
    };
    # 腾讯 QQ
    qq.enable = {
      type = bool;
      default = false;
    };
    # 远程桌面客户端
    rustdesk.enable = {
      type = bool;
      default = false;
    };
    # 即时通讯应用
    telegram-desktop.enable = {
      type = bool;
      default = false;
    };
    # 微信
    wechat.enable = {
      type = bool;
      default = false;
    };
  };
  # 终端模拟器
  terminal = {
    # 轻量级终端模拟器
    foot.enable = {
      type = bool;
      default = false;
    };
    # 跨平台 GPU 加速终端模拟器
    kitty.enable = {
      type = bool;
      default = false;
    };
  };
  # 环境配置
  environment = {
    i18n = {
      enable = {
        type = bool;
        default = false;
      };
      type = {
        type = str;
        default = "en-us";
      };
    };
  };
}
