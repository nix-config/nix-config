{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.service.udiskie.enable;
in
{
  config = lib.mkIf enableModule {
    # 自动挂载 U 盘
    environment.systemPackages = with pkgs; [
      udiskie
    ];
    services.udisks2.enable = true;
  };
}
