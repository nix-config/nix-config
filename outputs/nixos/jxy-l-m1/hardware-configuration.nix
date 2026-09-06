{
  lib,
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
      availableKernelModules = [ ];
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
    # 内核启动参数
    kernelParams = [
      # Amlogic UART 串口控制台
      "console=ttyAML0,115200n8"
      # HDMI 显示器控制台 (tty0 / framebuffer)
      "console=tty0"
    ];
  };
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
