vars: {
  # 主机配置
  host = {
    # 预定义选项集列表
    predefinedOptSetsList = with vars.optSets; [
      baseNixos
    ];
    # 自定义选项集
    customOptSets = {
      count = 1;
      system = "x86_64-linux";
      stateVersion = "26.05";
      nixConfigPath = "path/to/nix-config";
      cli = {
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
        nix-ld.enable = true;
      };
      # display.desktop = {
      #   enable = true;
      #   type = "hyprland";
      # };
      # environment.i18n.type = "zh-cn";
      hardware = {
        boot-loader = {
          efiSysMountPoint = "/boot";
          type = "systemd-boot";
        };
        disk.devices = {
          main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/sda"; };
        };
        # graphics.type = "none";
        networking = {
          # 防火墙
          firewall = {
            # 在防火墙中打开的端口
            # allowedTCPPorts = [ ... ];
            # allowedUDPPorts = [ ... ];
          };
          # 网络连接管理
          # networkmanager.enable = true;
          # 网络代理
          proxy = {
            # default = "http://user:password@proxy:port/";
            # noProxy = "127.0.0.1,localhost,internal.domain";
          };
        };
        zram.enable = true;
      };
      service.openssh.enable = true;
    };
  };
  # 用户配置
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
          # "networkmanager"
        ];
        hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
        openssh.authorizedKeys.keys = [ ];
      };
      # 预定义选项集列表
      predefinedOptSetsList = with vars.optSets; [
        baseEnv
        fishShell
      ];
      # 自定义选项集
      customOptSets = {
        # 输出数量
        count = 1;
      };
    };
  };
}
