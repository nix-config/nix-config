{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.service.sing-box.enable;
in
{
  config = lib.mkIf enableModule {
    services.sing-box = {
      enable = true;
    };
    # 启用 Linux 内核的 IP 转发功能
    boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  };
}
