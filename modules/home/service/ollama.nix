{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.service.ollama.enable;
  gpuType = opts.hardware.graphics.type;
in
{
  config = lib.mkIf enableModule {
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
