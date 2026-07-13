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
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
            "remote-build-binary-cache:cjK3U/pAP7CCcBDJk2Xe++jeCmX6crHoBB+wJGs6B5Y="
          ];
        };
        nix-ld.enable = true;
        sudo-rs.enable = true;
      };
      display = {
        desktop = {
          enable = true;
          type = "hyprland";
        };
        dms-shell.enable = true;
        font.enable = true;
        gtk.enable = true;
      };
      environment.i18n.type = "zh-cn";
      hardware = {
        bluetooth.enable = true;
        boot-loader.type = "systemd-boot";
        disk.devices = {
          main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/sda"; };
        };
        graphics.type = "amd";
        kernel = {
          configs = {
            DRM_XE = "no";
            DRM_I915 = "no";
            DRM_RADEON = "no";
            DRM_NOUVEAU = "no";
          };
          types = [ "kernel-cachyos-bore-lto-v3" ];
        };
        networking.networkmanager.enable = true;
        zram.enable = true;
      };
      service = {
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
        greetd.enable = true;
        libinput.enable = true;
        logind.enable = true;
        openlist.enable = true;
        openssh.enable = true;
        pipewire.enable = true;
        snapper.enable = true;
        sops-nix.enable = true;
        udiskie.enable = true;
      };
      tool.clash-verge.enable = true;
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
          zellij.enable = true;
        };
        editor = {
          nixvim.enable = true;
          vscode = {
            enable = true;
            extensions = [ "all" ];
          };
        };
        internet = {
          firefox.enable = true;
          qq.enable = true;
          rustdesk.enable = true;
          telegram-desktop.enable = true;
          wechat.enable = true;
        };
        media = {
          biu.enable = true;
          mpv.enable = true;
          obs-studio.enable = true;
          spotify.enable = true;
        };
        shell.bash.enable = true;
        terminal.kitty.enable = true;
        tool = {
          fcitx5.enable = true;
          lutris.enable = true;
        };
      };
    };
  };
}
