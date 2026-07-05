vars: {
  host = {
    customOptSets = {
      count = 1;
      system = "x86_64-linux";
      stateVersion = "26.05";
      nixConfigPath = "/home/admin/workspace/nix-config";
      cli = {
        nix-ld.enable = true;
        sudo-rs.enable = true;
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
      };
      desktop.type = "wsl";
      service = {
        comfyui.enable = true;
        openssh.enable = true;
        searxng.enable = true;
        sops-nix.enable = true;
        hermes-agent.enable = true;
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
      };
      hardware = {
        graphics.type = "nvidia";
        boot-loader.type = "wsl";
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
          nvitop.enable = true;
          zellij.enable = true;
          git.user = {
            name = "骑士姬";
            email = "2067834160@qq.com";
          };
          ssh = {
            enable = true;
            enableSshSecrets = [
              "id_ed25519_ssh"
              "id_ed25519_git"
            ];
          };
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
          zellij.enable = true;
          opencode.enable = true;
          codebase-memory-mcp.enable = true;
          git.user = {
            name = "小鲮鱼";
            email = "1835165361@qq.com";
          };
        };
        shell.bash.enable = true;
      };
    };
  };
}
