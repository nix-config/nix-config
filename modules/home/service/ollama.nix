{
  lib,
  opts,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  isAmd = (gpuType == "amd");
  isNvidia = (gpuType == "nvidia") || (gpuType == "nvidia-open");
in
{
  config = {
    services.ollama = lib.mkMerge [
      {
        enable = true;
        host = "0.0.0.0";
        port = 11434;
      }
      (lib.optionalAttrs isAmd {
        acceleration = "rocm";
      })
      (lib.optionalAttrs isNvidia {
        acceleration = "cuda";
      })
    ];
  };
}
