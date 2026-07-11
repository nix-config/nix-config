{
  lib,
  pkgs,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.comfyui.enable && (opts.hardware.graphics.type == "nvidia");
  isWsl = opts.hardware.boot-loader.type == "wsl";
  # 定义模型
  realesrgan-x4plus-anime-6b = pkgs.fetchResource {
    name = "RealESRGAN_x4plus_anime_6B.pth";
    url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth";
    hash = "sha256-+HLYN9PJDtLgUie+1xGvVnGm/RyffX6RyRGmHxVemdo=";
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
  config = lib.mkIf enableModule (
    lib.mkMerge [
      {
        services.comfyui = {
          enable = true;
          host = "0.0.0.0";
          port = 8188;
          acceleration = "cuda";
          customNodes = with pkgs.comfyuiPackages; [
            comfyui-rgthree
            comfyui-crystools
            comfyui-ultimatesdupscale
            comfyui-pythongosssss-custom-scripts
          ];
          models = [
            realesrgan-x4plus-anime-6b
            diffusion-pytorch-model-promax
          ];
        };
      }
      (lib.optionalAttrs (!isWsl) {
        systemd.services.comfyui = {
          environment.LD_LIBRARY_PATH = "${config.hardware.nvidia.package.out}/lib";
        };
      })
      (lib.optionalAttrs isWsl {
        systemd.services.comfyui = {
          serviceConfig.DeviceAllow = [ "/dev/dxg rwm" ];
          environment.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
        };
      })
    ]
  );
}
