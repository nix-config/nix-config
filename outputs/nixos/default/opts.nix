{
  vars,
  optSets,
  hostName,
  ...
}:
let
  host = {
    # 预定义选项集列表
    # predefinedOptSetsList = with optSets; [ ];
    # 自定义选项集
    customOptSets = {
      # 输出数量
      count = 1;
      # 输出平台
      system = vars.systemTypes.x86_64-linux;
      # 初始状态版本
      stateVersion = "26.05";
      # nix-config 仓库路径
      nixConfigPath = "path/to/nix-config";
      # ========== 命令行工具 ==========
      cli = {
        # 在 NixOS 上运行未打补丁的动态二进制文件
        nix-ld.enable = true;
        # Nix 包管理器配置
        nix = {
          substituters = [
            # 上海交大镜像源
            # "https://mirror.sjtu.edu.cn/nix-channels/store"
            # 中科大镜像源
            # "https://mirrors.ustc.edu.cn/nix-channels/store"
            # 清华镜像源
            # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
            # nixified-ai 缓存
            # "https://ai.cachix.org"
            # garnix 缓存
            # "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            # "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
            # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ];
        };
      };
      # ========== 实用工具 ==========
      tool = {
        # Clash 代理客户端
        clash-verge.enable = false;
      };
      # ========== 本地化和语言 ==========
      i18n = {
        # 语言环境, 可选项:
        # en-us
        # zh-cn
        locale = vars.localeTypes.en-us;
      };
      # ========== 桌面环境 ==========
      desktop = {
        # 桌面类型, 可选项:
        # disable (不启用桌面, 这将连带禁用所有图形应用)
        # hyprland
        type = vars.desktopTypes.disable;
        # DankMaterialShell
        dms = {
          enable = false;
          # 软件渲染模式 (用于无 GPU 或虚拟化环境)
          softwareRenderingEnable = false;
        };
      };
      # ========== 系统服务 ==========
      service = {
        # 内核级透明代理
        daed.enable = false;
        # HTTP 和反向代理 web 服务器
        nginx.enable = false;
        # 轻量级登录管理器
        greetd.enable = false;
        # 系统登录和电源管理
        logind.enable = false;
        # SSH 服务器
        openssh.enable = true;
        # ComfyUI Web 服务
        comfyui.enable = false;
        # Btrfs 快照管理工具
        snapper.enable = false;
        # U 盘自动挂载服务
        udiskie.enable = false;
        # 多媒体框架, 替代 PulseAudio
        pipewire.enable = false;
        # 输入设备驱动服务
        libinput.enable = false;
        # 通用代理工具
        sing-box.enable = false;
        # Sops Nix 服务
        sops-nix.enable = false;
        # 支持多种存储的文件列表程序
        openlist.enable = false;
        # 内网穿透工具
        frp = {
          enable = false;
          role = vars.frpRoleTypes.server;
          proxies = [ ];
        };
        # P2P VPN 服务
        zerotierone = {
          enable = false;
          # 加入的网络
          joinNetworks = [ ];
        };
        # 远程桌面服务器
        rustdesk-server = {
          enable = false;
          # 中继地址
          relayHosts = [ ];
        };
      };
      # ========== 硬件配置 ==========
      hardware = {
        # 内存压缩配置
        zram.enable = false;
        # 蓝牙配置
        bluetooth.enable = false;
        # 磁盘配置, 具体定义查看: vars/diskPartitionTypes/
        disk = {
          main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/sda"; };
        };
        # 内核配置, 具体定义查看: vars/kernelTypes/
        # kernel = with vars.kernelTypes; [
        #   zen.latest
        #   xanmod.latest
        #   generic.latest
        #   ...
        # ];
        # 图形驱动配置
        graphics = {
          # GPU 类型, 可选项:
          # none (默认)
          # amd
          # nvidia
          type = vars.gpuTypes.none;
        };
        # 网络配置
        networking = {
          # 主机名
          inherit hostName;
          # 网络连接管理
          networkmanager.enable = false;
          # 网络代理
          proxy = {
            # default = "http://user:password@proxy:port/";
            # noProxy = "127.0.0.1,localhost,internal.domain";
          };
          # 防火墙
          firewall = {
            # 在防火墙中打开的端口
            # allowedTCPPorts = [ ... ];
            # allowedUDPPorts = [ ... ];
          };
        };
        boot-loader = {
          # EFI 系统分区挂载点
          efiSysMountPoint = "/boot";
          # 启动加载器, 可选项:
          # systemd-boot (默认)
          # grub (目前未实现)
          type = vars.bootLoaderTypes.systemd-boot;
        };
      };
      # ========== 容器管理 ==========
      container = {
        enable = false;
        # 容器运行时类型, 可选项:
        # podman (默认)
        # docker
        type = vars.containerTypes.podman;
        # Arch 开发容器
        dev-arch.enable = true;
        # Portainer 代理
        portainer-agent.enable = false;
      };
    };
  };
  # ========== 用户配置 ==========
  users = {
    root = {
      base = {
        # 哈希密码
        hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
        # SSH 公钥
        openssh.authorizedKeys.keys = [ ];
      };
    };
    admin = {
      base = {
        # 普通用户
        isNormalUser = true;
        # 用户描述
        description = "管理员";
        # 添加用户到额外组
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
        openssh.authorizedKeys.keys = [ ];
      };
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
          # 命令运行器, 类似 Makefile
          # just.enable = true;
          # 密钥管理工具
          sops.enable = false;
          # nix LSP 程序
          nixd.enable = false;
          # 环境变量管理工具
          direnv.enable = false;
          # 基于 Rust 的新一代终端复用器
          zellij.enable = false;
          # 终端复用器, 可在一个终端中运行多个会话
          tmux.enable = false;
          # 用 Rust 编写的快速文件管理器
          # yazi.enable = true;
          # 系统资源监控器
          # btop.enable = true;
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
          # 安全远程登录客户端
          ssh = {
            enable = false;
            # 需要解密的 ssh 密钥名称列表
            enableSshSecrets = [ ];
          };
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
          vscode = {
            enable = false;
            # 扩展开关, 其中 all 为全部开启
            extensions = {
              all.enable = false;
              # go.enable = true;
              # nix.enable = true;
              # base.enable = true;
              # rust.enable = true;
              # python.enable = true;
              # remote.enable = true;
              # reader.enable = true;
              # markdown.enable = true;
              # javascript.enable = true;
            };
          };
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
      };
    };
  };
in
{
  inherit host;
  inherit users;
}
