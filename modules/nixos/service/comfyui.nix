{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.comfyui or { };
  finallyEnable = cfg.enable or false;
  # 定义模型
  realesrgan-x4plus-anime-6b = pkgs.fetchResource {
    name = "RealESRGAN_x4plus_anime_6B.pth";
    url = "https://huggingface.co/spaces/Marne/Real-ESRGAN/blob/main/RealESRGAN_x4plus_anime_6B.pth";
    hash = "sha256-+knS/IugSoGGnRKT7x2FesZnF+ii4WX8+uRQzsdirCo=";
    passthru.comfyui.installPaths = [ "upscale_models" ];
  };
  diffusion-pytorch-model-promax = pkgs.fetchResource {
    name = "diffusion_pytorch_model_promax.safetensors";
    url = "https://huggingface.co/xinsir/controlnet-union-sdxl-1.0/resolve/main/diffusion_pytorch_model_promax.safetensors";
    hash = "sha256-n64uUMtDG/y+BYIrWewiKN9UXvJ/cR3qiUnp9O2ffNw=";
    passthru.comfyui.installPaths = [ "controlnet" ];
  };
in
{
  imports = [
    inputs.nixified-ai.nixosModules.comfyui
  ];
  config = lib.mkIf finallyEnable {
    services.comfyui = {
      enable = true;
      host = "0.0.0.0";
      acceleration = "cuda";
      customNodes = with pkgs.comfyuiPackages; [
        comfyui-rgthree
        comfyui-crystools
        comfyui-pythongosssss-custom-scripts
      ];
      models = [
        realesrgan-x4plus-anime-6b
        diffusion-pytorch-model-promax
      ];
    };
  };
}
