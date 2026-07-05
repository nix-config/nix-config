vars: {
  host = {
    customOptSets = {
      count = 1;
      system = "x86_64-linux";
      stateVersion = "26.05";
      nixConfigPath = "/home/admin/workspace/nix-config";
      cli.nix = {
        substituters = [
          "https://cache.garnix.io"
        ];
        trusted-public-keys = [
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "remote-build-binary-cache:cjK3U/pAP7CCcBDJk2Xe++jeCmX6crHoBB+wJGs6B5Y="
        ];
      };
      tool.clash-verge.enable = true;
      i18n.locale = "en-us";
      service = {
        openssh.enable = true;
        sops-nix.enable = true;
        frp = {
          enable = true;
          role = "server";
        };
        rustdesk-server = {
          enable = true;
          relayHosts = [ "knightfemale.com:21117" ];
        };
      };
      hardware = {
        zram.enable = true;
        graphics.type = "none";
        disk.main = vars.diskPartitionTypes.efi-ext4 {
          device = "/dev/vda";
          espSize = "100M";
        };
        kernel = {
          types = [ "kernel-cachyos-server-lto" ];
          configs = {
            DRM_XE = "no";
            DRM_I915 = "no";
            DRM_AMDGPU = "no";
            DRM_RADEON = "no";
            DRM_NOUVEAU = "no";
          };
        };
        boot-loader.type = "systemd-boot";
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
        cli.zellij.enable = true;
        shell.bash.enable = true;
      };
    };
  };
}
