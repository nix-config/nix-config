{
  pkgs,
  opts,
  inputs,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  isNvidia = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  # torch/torchvision 换成预编译 CUDA wheel, 避免源码构建 CUDA torch
  package =
    if isNvidia then
      pkgs.lada.override {
        torch = pkgs.python3Packages.torch-bin;
        torchvision = pkgs.python3Packages.torchvision-bin;
      }
    else
      pkgs.lada;
in
{
  imports = [
    inputs.nur.repos.knightfemale.modules.homeManager.lada
  ];
  config.programs.lada = {
    enable = true;
    inherit package;
    models = [
      {
        name = "lada_mosaic_detection_model_v4_accurate.pt";
        url = "https://huggingface.co/ladaapp/lada/resolve/main/lada_mosaic_detection_model_v4_accurate.pt";
        hash = "sha256-wkTX5J2PiOJkuNwV+R+yH1kIrY+28wC3vIhGLQgBvB8=";
      }
      {
        name = "lada_mosaic_restoration_model_generic_v1.2_full.pth";
        url = "https://huggingface.co/ladaapp/lada/resolve/main/lada_mosaic_restoration_model_generic_v1.2_full.pth";
        hash = "sha256-jFLMtcu/YK7gFoRnsveHyOocLk9Bpk1nmpCzfNwdrTw=";
      }
    ];
  };
}
