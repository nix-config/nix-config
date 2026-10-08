{
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:
{
  # 硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  # 启动相关配置
  boot = {
    # initrd 阶段加载的模块 (根文件系统挂载前)
    initrd = {
      # 由 udev 自动探测加载的模块列表 (会打包进 initrd)
      # 这些模块用于在早期启动时识别硬件
      availableKernelModules = [
        "ata_piix" # Intel PIIX/ICH IDE/SATA 控制器驱动
        "uhci_hcd" # USB 1.1 主控制器驱动
        "virtio_pci" # Virtio PCI 传输驱动
        "virtio_blk" # Virtio 块设备驱动 (虚拟磁盘)
      ];
      # 不依赖自动探测强制加载的模块
      # 适用于根文件系统所在设备的驱动或任何必须在早期就绪的模块
      kernelModules = [ ];
    };
    # 第二阶段加载的模块 (根文件系统挂载后)
    # 这些模块由 systemd/udev 在系统启动后期加载非关键硬件或功能
    kernelModules = [ ];
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
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
