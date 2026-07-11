{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = (opts.hardware.graphics.type == "nvidia");
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      nvitop
    ];
  };
}
