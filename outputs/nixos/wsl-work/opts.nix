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
      stateVersion = "25.11";
      nixConfigPath = "/home/admin/workspace/nix-config";
      cli = {
        nix-ld.enable = true;
        nix = {
          substituters = [
            "https://mirror.sjtu.edu.cn/nix-channels/store"
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ];
        };
      };
      i18n.locale = vars.localeTypes.zh-cn;
      service = {
        openssh.enable = true;
        sops-nix.enable = true;
        frp = {
          enable = true;
          role = vars.frpRoleTypes.client;
          proxies = [
            {
              name = "ssh-wsl-work";
              type = "tcp";
              localIP = "localhost";
              localPort = 22;
              remotePort = 2226;
            }
          ];
        };
      };
      hardware = {
        zram.enable = true;
        graphics.type = vars.gpuTypes.none;
        networking = {
          inherit hostName;
          firewall.enable = false;
          resolvconf.enable = false;
        };
        boot-loader.type = vars.bootLoaderTypes.wsl;
      };
      container = {
        enable = true;
        type = vars.containerTypes.podman;
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
        ];
        hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
      predefinedOptSetsList = [
        optSets.devEnv
        optSets.baseEnv
        optSets.fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          ssh.enable = true;
          direnv.enable = true;
          opencode.enable = true;
          git.user = {
            name = "Knight";
            email = "2067834160@qq.com";
          };
        };
        shell.bash.enable = true;
        editor.nixvim.enable = true;
      };
    };
  };
in
{
  inherit host;
  inherit users;
}
