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
        nix-ld.enable = true;
        sudo-rs.enable = true;
        nix = {
          substituters = [
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
            "remote-build-binary-cache:cjK3U/pAP7CCcBDJk2Xe++jeCmX6crHoBB+wJGs6B5Y="
          ];
        };
      };
      tool.clash-verge.enable = true;
      display = {
        desktop = {
          enable = true;
          type = "hyprland";
        };
        dms.enable = true;
        gtk.enable = true;
        font.enable = true;
      };
      service = {
        greetd.enable = true;
        logind.enable = true;
        openssh.enable = true;
        snapper.enable = true;
        udiskie.enable = true;
        openlist.enable = true;
        pipewire.enable = true;
        libinput.enable = true;
        sops-nix.enable = true;
        frp = {
          enable = true;
          role = "client";
          proxies = [
            {
              name = "ssh-fl8850ua";
              type = "tcp";
              localIP = "localhost";
              localPort = 22;
              remotePort = 2222;
            }
            {
              name = "openlist";
              type = "tcp";
              localIP = "localhost";
              localPort = 5244;
              remotePort = 5244;
            }
          ];
        };
      };
      hardware = {
        zram.enable = true;
        bluetooth.enable = true;
        graphics.type = "amd";
        disk.devices = {
          main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/sda"; };
        };
        kernel = {
          types = [ "kernel-cachyos-bore-lto-v3" ];
          configs = {
            DRM_XE = "no";
            DRM_I915 = "no";
            DRM_RADEON = "no";
            DRM_NOUVEAU = "no";
          };
        };
        networking.networkmanager.enable = true;
        boot-loader.type = "systemd-boot";
      };
      environment.i18n.type = "zh-cn";
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
        devEnv
        baseEnv
        fishShell
        opencodeEnv
      ];
      customOptSets = {
        count = 1;
        cli = {
          direnv.enable = true;
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
        tool = {
          fcitx5.enable = true;
          lutris.enable = true;
        };
        media = {
          biu.enable = true;
          mpv.enable = true;
          spotify.enable = true;
          obs-studio.enable = true;
        };
        shell.bash.enable = true;
        editor = {
          nixvim.enable = true;
          vscode = {
            enable = true;
            extensions = [ "all" ];
          };
        };
        terminal.kitty.enable = true;
        internet = {
          qq.enable = true;
          wechat.enable = true;
          firefox.enable = true;
          rustdesk.enable = true;
          telegram-desktop.enable = true;
        };
      };
    };
  };
}
