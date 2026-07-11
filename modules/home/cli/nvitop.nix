{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.cli.nvitop.enable && (opts.hardware.graphics.type == "nvidia");
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      nvitop
    ];
  };
}
