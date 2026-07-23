{
  lib,
  pkgs,
  opts,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      nvitop
    ];
  };
}
