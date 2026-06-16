{
  vars,
  optSets,
  hostName,
  ...
}:
let
  host = {
    customOptSets = {
      count = 1;
      system = vars.systemTypes.x86_64-linux;
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
      i18n.locale = vars.localeTypes.zh-cn;
      desktop = {
        type = vars.desktopTypes.hyprland;
        dms.enable = true;
      };
      service = {
        greetd.enable = true;
        logind.enable = true;
        openssh.enable = true;
        snapper.enable = true;
        udiskie.enable = true;
        searxng.enable = true;
        openlist.enable = true;
        pipewire.enable = true;
        libinput.enable = true;
        sops-nix.enable = true;
        hermes-agent.enable = true;
        frp = {
          enable = true;
          role = vars.frpRoleTypes.client;
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
        graphics.type = vars.gpuTypes.amd;
        disk.main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/sda"; };
        kernel = [ "kernel-cachyos-bore-lto-v3" ];
        networking = {
          inherit hostName;
          networkmanager.enable = true;
        };
        boot-loader.type = vars.bootLoaderTypes.systemd-boot;
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
          "alist"
          "wheel"
          "hermes"
          "networkmanager"
        ];
        hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
      predefinedOptSetsList = with optSets; [
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
          mpv.enable = true;
          spotify.enable = true;
          obs-studio.enable = true;
        };
        shell.bash.enable = true;
        editor = {
          nixvim.enable = true;
          vscode = {
            enable = true;
            extensions.all.enable = true;
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
      predefinedOptSetsList = with optSets; [
        devEnv
        baseEnv
        fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          opencode.enable = true;
          git.user = {
            name = "小鲮鱼";
            email = "1835165361@qq.com";
          };
        };
        shell.bash.enable = true;
        desktop.type = vars.desktopTypes.disable;
      };
    };
  };
in
{
  inherit host;
  inherit users;
}
