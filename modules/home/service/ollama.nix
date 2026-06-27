{
  lib,
  opts,
  ...
}:
let
  cfg = opts.service.ollama or { };
  finallyEnable = cfg.enable or false;
  gpuType = opts.hardware.graphics.type or "";
in
{
  config = lib.mkIf finallyEnable {
    services.ollama = lib.mkMerge [
      {
        enable = true;
        host = "0.0.0.0";
        port = 11434;
      }
      (lib.optionalAttrs (gpuType == "amd") {
        acceleration = "rocm";
      })
      (lib.optionalAttrs (gpuType == "nvidia") {
        acceleration = "cuda";
      })
    ];
  };
}
