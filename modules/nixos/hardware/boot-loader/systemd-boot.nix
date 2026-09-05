{
  lib,
  opts,
  ...
}:
let
  cfg = opts.hardware.boot-loader;
  enableModule = (cfg.type == "systemd-boot");
  inherit (cfg) efiSysMountPoint;
in
{
  config = lib.mkIf enableModule {
    boot.loader = {
      efi = {
        # 允许修改 EFI 变量, 支持 UEFI 引导
        canTouchEfiVariables = true;
        # EFI系统分区挂载点
        inherit efiSysMountPoint;
      };
      # 启用 systemd-boot 引导程序
      systemd-boot.enable = true;
    };
  };
}
