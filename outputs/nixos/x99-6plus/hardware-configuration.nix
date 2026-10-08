{
  lib,
  pkgs,
  config,
  inputs,
  modulesPath,
  ...
}:
{
  # 硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  # 启动相关配置
  boot = {
    # initrd 阶段加载的模块 (根文件系统挂载前)
    initrd = {
      # 由 udev 自动探测加载的模块列表 (会打包进 initrd)
      # 这些模块用于在早期启动时识别硬件
      availableKernelModules = [
        "nvme" # NVMe 固态硬盘驱动
        "ahci" # SATA 接口驱动
        "sd_mod" # SCSI 磁盘驱动
        "ehci_pci" # USB 2.0 主控制器驱动
        "xhci_pci" # USB 3.x 主控制器驱动
      ];
      # 不依赖自动探测强制加载的模块
      # 适用于根文件系统所在设备的驱动或任何必须在早期就绪的模块
      kernelModules = [ ];
    };
    # 第二阶段加载的模块 (根文件系统挂载后)
    # 这些模块由 systemd/udev 在系统启动后期加载非关键硬件或功能
    kernelModules = [
      "kvm-intel" # Intel 虚拟化支持 (KVM 模块)
    ];
    # 额外的第三方内核模块包
    # 如需在 initrd 阶段加载其中的模块, 请加入 initrd.kernelModules
    extraModulePackages = [ ];
    # 内核包
    kernelPackages =
      pkgs.linuxPackagesFor
        inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linux-cachyos-server-lto;
    # 内核补丁
    kernelPatches = [
      {
        name = "extra-kernel-config";
        patch = null;
        structuredExtraConfig = {
          DRM_XE = lib.kernel.no;
          DRM_I915 = lib.kernel.no;
          DRM_AMDGPU = lib.kernel.no;
          DRM_RADEON = lib.kernel.no;
          DRM_NOUVEAU = lib.kernel.no;
        };
      }
    ];
  };
  # 指定 Nixpkgs 编译和打包时使用的主机平台架构
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # 启用 Intel CPU 微码更新, 从可分发的固件中加载更新
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
