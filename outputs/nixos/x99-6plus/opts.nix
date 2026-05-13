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
      service = {
        openssh.enable = true;
        sops-nix.enable = true;
        openlist.enable = true;
        frp = {
          enable = true;
          role = vars.frpRoleTypes.client;
          proxies = [
            {
              name = "ssh-x99-6plus";
              type = "tcp";
              localIP = "localhost";
              localPort = 22;
              remotePort = 2227;
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
        graphics.type = vars.gpuTypes.nvidia;
        disk = {
          main = vars.diskPartitionTypes.efi-btrfs-subvolumes { device = "/dev/nvme0n1"; };
          data = vars.diskPartitionTypes.xfs {
            device = "/dev/sda";
            mountpoint = "/mnt/data";
          };
        };
        kernel = [
          vars.kernelTypes.latest
        ];
        networking = {
          inherit hostName;
          networkmanager.enable = false;
          firewall.enable = false;
        };
        boot-loader.type = vars.bootLoaderTypes.systemd-boot;
      };
      container = {
        enable = true;
        dev-arch.enable = true;
      };
    };
  };
  users = {
    root = {
      base = {
        hashedPassword = "$6$yk.jU.kxIAVwaoaj$zFEdwFofY8P88Ad7/a62sm5j3QxyXcQxKTvTpRMIYDgw6G4RDXZCQgHRyeOyZHLN10lKov55WJESL8t2Ia1US0";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
          "command=\"podman exec -it dev-arch bash\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOwMGFFdCo3DM1mKZTipGe4/M1opXvNAJttgrY7TIPs"
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
      predefinedOptSetsList = [
        optSets.baseEnv
        optSets.fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          zellij.enable = true;
          nvitop.enable = true;
        };
        shell.bash.enable = true;
      };
    };
  };
in
{
  inherit host;
  inherit users;
}
