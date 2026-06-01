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
            "https://attic.xuyh0120.win/lantian"
            "https://ai.cachix.org"
            "https://cache.garnix.io"
            "https://mirror.sjtu.edu.cn/nix-channels/store"
          ];
          trusted-public-keys = [
            "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
            "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ];
        };
      };
      service = {
        openssh.enable = true;
        comfyui.enable = true;
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
            {
              name = "ollama";
              type = "tcp";
              localIP = "localhost";
              localPort = 11434;
              remotePort = 11434;
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
        kernel = with vars.kernelTypes; [ cachyos.server-lto ];
        networking.hostName = hostName;
        boot-loader.type = vars.bootLoaderTypes.systemd-boot;
      };
      container = {
        enable = true;
        type = vars.containerTypes.podman;
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
          ''command="${host.customOptSets.nixConfigPath}/scripts/ssh-container-intelligent-entry.sh dev-arch",no-X11-forwarding,no-agent-forwarding ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmCmFzsdE+O2Xmi58kcN4gYuW+Y1Zlz8bnHWJ4MYpyD''
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
      predefinedOptSetsList = with optSets; [
        baseEnv
        fishShell
      ];
      customOptSets = {
        count = 1;
        cli = {
          direnv.enable = true;
          zellij.enable = true;
          nvitop.enable = true;
        };
        shell.bash.enable = true;
        service.ollama.enable = true;
      };
    };
  };
in
{
  inherit host;
  inherit users;
}
