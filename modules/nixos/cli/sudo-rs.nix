{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.sudo-rs or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    security.sudo-rs = {
      enable = true;
      # 只允许 wheel 组成员可执行 sudo
      execWheelOnly = true;
    };
  };
}
