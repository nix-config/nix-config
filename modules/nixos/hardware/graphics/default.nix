{
  lib,
  opts,
  ...
}:
let
  isWsl = (opts.hardware.boot-loader.type == "wsl");
  enableModule = opts.hardware.graphics.enable && (!isWsl);
in
{
  config = lib.mkIf enableModule {
    hardware.graphics.enable = true;
  };
}
