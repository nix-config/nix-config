vars: {
  # 主机配置
  host = {
    # 预定义选项集列表
    # predefinedOptSetsList = with optSets; [ ];
    # 自定义选项集
    customOptSets = {
      count = 1;
      system = "x86_64-linux";
      stateVersion = "26.05";
      nixConfigPath = "path/to/nix-config";
      cli = {
        nix-ld.enable = true;
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
      i18n.locale = "en-us";
      desktop.type = "none";
      service.openssh.enable = true;
      hardware = {
        zram.enable = true;
        disk.main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/sda"; };
        graphics.type = "none";
        networking = {
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
          type = "systemd-boot";
          efiSysMountPoint = "/boot";
        };
      };
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
