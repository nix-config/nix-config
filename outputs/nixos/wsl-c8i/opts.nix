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
      cli = {
        nix = {
          substituters = [
            "https://ai.cachix.org"
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
            "remote-build-binary-cache:cjK3U/pAP7CCcBDJk2Xe++jeCmX6crHoBB+wJGs6B5Y="
          ];
        };
        nix-ld.enable = true;
        sudo-rs.enable = true;
      };
      display.desktop.enable = true;
      environment.i18n.type = "zh-cn";
      hardware = {
        boot-loader.type = "wsl";
        graphics = {
          enable = true;
          type = "nvidia-open";
        };
        networking.extraSettings.resolvconf.enable = false;
      };
      service = {
        comfyui = {
          enable = true;
          extraFlags = [
            "--bf16-unet"
            "--bf16-vae"
            "--bf16-text-enc"
            "--use-pytorch-cross-attention"
            "--lowvram"
            "--cache-lru"
            "8"
            "--preview-metho"
            "taesd"
            "--fast"
          ];
        };
        frp = {
          enable = true;
          role = "client";
          proxies = [
            {
              name = "ssh-wsl-c8i";
              type = "tcp";
              localIP = "localhost";
              localPort = 22;
              remotePort = 2224;
            }
          ];
        };
        hermes-agent.enable = true;
        openssh.enable = true;
        searxng.enable = true;
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
          "hermes"
        ];
        hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
      predefinedOptSetsList = with vars.optSets; [
        devEnv
        baseEnv
        fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          direnv.enable = true;
          git.user = {
            name = "骑士姬";
            email = "2067834160@qq.com";
          };
          mcp = {
            enable = true;
            enabledMcps = [ "all" ];
          };
          nvitop.enable = true;
          opencode.enable = true;
          ssh = {
            enable = true;
            enableSshSecrets = [
              "id_ed25519_ssh"
              "id_ed25519_git"
            ];
          };
          zellij.enable = true;
        };
        shell.bash.enable = true;
      };
    };
    hermes = {
      base = {
        description = "林予";
        extraGroups = [
          "wheel"
        ];
        hashedPassword = "$y$j9T$nczqPz4yX8Lop8pOnvIrD.$KqLOYhzxJ4x80jNCFtd6HPSgC.xYzlrMD1BFGi6PVYB";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
      predefinedOptSetsList = with vars.optSets; [
        devEnv
        baseEnv
        fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          direnv.enable = true;
          git.user = {
            name = "小鲮鱼";
            email = "1835165361@qq.com";
          };
          opencode.enable = true;
          zellij.enable = true;
        };
        shell.bash.enable = true;
      };
    };
  };
}
