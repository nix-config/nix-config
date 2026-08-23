vars: {
  host = {
    predefinedOptSetsList = with vars.optSets; [
      baseNixos
    ];
    customOptSets = {
      count = 1;
      system = "x86_64-linux";
      stateVersion = "26.05";
      nixConfigPath = "/home/admin/workspace/nix-config";
      cli.nix = {
        substituters = [
          "https://ai.cachix.org"
        ];
        trusted-public-keys = [
          "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
          "remote-build-binary-cache:cjK3U/pAP7CCcBDJk2Xe++jeCmX6crHoBB+wJGs6B5Y="
        ];
      };
      environment.type = "zh-cn";
      hardware = {
        boot-loader.type = "systemd-boot";
        disk.devices = {
          main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/nvme0n1"; };
          data = vars.diskPartitionTypes.xfs {
            device = "/dev/sda";
            mountpoint = "/mnt/data";
          };
        };
        graphics = {
          enable = true;
          type = "nvidia-open";
        };
        kernel = {
          configs = {
            DRM_XE = "no";
            DRM_I915 = "no";
            DRM_AMDGPU = "no";
            DRM_RADEON = "no";
            DRM_NOUVEAU = "no";
          };
          name = "linux-cachyos-server-lto";
        };
        zram.enable = true;
      };
      service = {
        frp = {
          enable = true;
          role = "client";
          proxies = [
            {
              name = "ssh-x99-6plus";
              type = "tcp";
              localIP = "localhost";
              localPort = 22;
              remotePort = 2227;
            }
          ];
        };
        llama-cpp = {
          enable = true;
          extraSettings = {
            # 模型别名
            alias = "qwen3.8-27b";
            # 用于认证的 API 密钥 (逗号分隔列表)
            api-key = "1";
            # 加载模型路径
            model = "/mnt/data/huggingface/Qwen3.8-27B-IQ4_XS.gguf";
            # 多模态投影文件路径
            mmproj = "/mnt/data/huggingface/mmproj-Qwen3.8-27B-BF16.gguf";
            # 卸载到每个 GPU 的模型比例 (逗号分隔)
            tensor-split = "1,2";
            # 大幅降低长上下文推理时的显存占用和首字延迟
            flash-attn = "on";
            # 加载到GPU的模型层数
            n-gpu-layers = "all";
            # 并发数量
            parallel = 1;
            # 张量分割模式
            split-mode = "layer";
            # 禁用内存映射
            load-mode = "none";
            # 逻辑最大批次大小
            batch-size = 2048;
            # 物理最大批次大小
            ubatch-size = 512;
            # 提示词上下文大小
            ctx-size = 131072;
            # 温度参数
            temp = 1.0;
            # 候选概率最⾼的 token 数
            top-k = 20;
            # 从前多少概率的 token 里选
            top-p = 0.95;
            # 最小概率阈值
            min-p = 0;
            # 存在惩罚
            presence-penalty = 0.0;
            # 重复惩罚
            repeat-penalty = 1.0;
            # 是否对聊天使用 Jinja 模板引擎
            jinja = true;
            # 输出详细日志
            verbose = false;
          };
        };
        openssh.enable = true;
        sops-nix.enable = true;
      };
    };
  };
  users = {
    root = {
      base = {
        hashedPassword = "$6$yk.jU.kxIAVwaoaj$zFEdwFofY8P88Ad7/a62sm5j3QxyXcQxKTvTpRMIYDgw6G4RDXZCQgHRyeOyZHLN10lKov55WJESL8t2Ia1US0";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
    };
    admin = {
      base = {
        isNormalUser = true;
        description = "管理员";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
      predefinedOptSetsList = with vars.optSets; [
        baseEnv
        fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          nvitop.enable = true;
          ssh = {
            enable = true;
            enableSshSecrets = [ "id_ed25519_ssh" ];
          };
          zellij.enable = true;
        };
        shell.bash.enable = true;
      };
    };
  };
}
