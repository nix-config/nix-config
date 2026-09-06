{
  lib,
  opts,
  ...
}:
let
  cfg = opts.hardware.boot-loader;
  enableModule = (cfg.type == "extlinux");
in
{
  config = lib.mkIf enableModule {
    boot.loader = {
      generic-extlinux-compatible = {
        enable = true;
        mirroredBoots = [ { path = "/boot"; } ];
      };
      # 与 generic-extlinux 冲突, 必须显式禁用
      grub.enable = false;
    };
  };
}
