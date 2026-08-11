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
            alias = "qwen3.6-35b-a3b";
            model = "/mnt/data/huggingface/Qwen3.6-35B-A3B-IQ4_XS.gguf";
            mmproj = "/mnt/data/huggingface/mmproj-Qwen3.6-35B-A3B-f16.gguf";
            tensor-split = "1,3";
            ctx-size = 262144;
            temp = 1.0;
            top-k = 20;
            top-p = 0.95;
            presence-penalty = 1.5;
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
