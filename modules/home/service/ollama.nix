{
  lib,
  opts,
  ...
}:
let
  cfg = opts.service.ollama or { };
  finallyEnable = cfg.enable or false;
  gpuType = opts.hardware.graphics.type or "";
  acceleration =
    if gpuType == "nvidia" then
      "cuda"
    else if gpuType == "amd" then
      "rocm"
    else
      null;
in
{
  config = lib.mkIf finallyEnable {
    services.ollama = {
      enable = true;
      host = "0.0.0.0";
      port = 11434;
      inherit acceleration;
    };
  };
}
