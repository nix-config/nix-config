{
  lib,
  opts,
  config,
  ...
}:
let
  enableModule = (opts.hardware.graphics.type == "nvidia");
  containerEnable = opts.service.container.enable;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
in
{
  config = lib.mkIf enableModule (
    lib.mkMerge [
      (lib.optionalAttrs (!isWsl) {
        # 为 Xorg 和 Wayland 加载 NVIDIA 驱动
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware = {
          nvidia = {
            # 必须开启模式设置
            modesetting.enable = true;
            # 实验性电源管理, 可能影响休眠/挂起
            # 若唤醒后出现花屏或程序崩溃, 可尝试开启, 它会将完整显存保存至 /tmp 来修复
            powerManagement.enable = false;
            # 精细电源管理: 空闲时关闭 GPU (实验性, 仅支持 20 系及更新的架构)
            powerManagement.finegrained = false;
            # 使用 NVIDIA 开源内核模块 (并非 nouveau 驱动)
            # 仅支持 20 系及更新的架构, 需要驱动版本 515.43.04+
            # 兼容 GPU 列表: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
            open = true;
            # 是否启用 NVIDIA 设置界面 (可通过 nvidia-settings 访问)
            nvidiaSettings = false;
            # 按需选择适合你 GPU 的驱动版本, 此处为最新版
            package = config.boot.kernelPackages.nvidiaPackages.latest;
          };
          # 启动时运行 nvidia-container-toolkit, 启用Nvidia设备的动态CDI配置
          nvidia-container-toolkit.enable = containerEnable;
        };
        environment.sessionVariables.LD_LIBRARY_PATH = [
          "${config.hardware.nvidia.package.out}/lib"
        ];
      })
      (lib.optionalAttrs isWsl {
        environment.sessionVariables.LD_LIBRARY_PATH = [
          "/usr/lib/wsl/lib"
        ];
      })
    ]
  );
}
