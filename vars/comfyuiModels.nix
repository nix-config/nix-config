inputs: {
  diffusion-pytorch-model-promax = {
    name = "diffusion_pytorch_model_promax.safetensors";
    url = "https://huggingface.co/xinsir/controlnet-union-sdxl-1.0/resolve/main/diffusion_pytorch_model_promax.safetensors";
    hash = "sha256-n64uUMtDG/y+BYIrWewiKN9UXvJ/cR3qiUnp9O2ffNw=";
    passthru.comfyui.installPaths = [ "controlnet" ];
  };
  realesrgan-x4plus-anime-6b = {
    name = "RealESRGAN_x4plus_anime_6B.pth";
    url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth";
    hash = "sha256-+HLYN9PJDtLgUie+1xGvVnGm/RyffX6RyRGmHxVemdo=";
    passthru.comfyui.installPaths = [ "upscale_models" ];
  };
  z-anime-base-aio-bf16 = {
    name = "z-anime-base-aio-bf16.safetensors";
    url = "https://huggingface.co/SeeSee21/Z-Anime/resolve/main/aio/z-anime-base-aio-bf16.safetensors";
    hash = "sha256-kKi2xnVXzuBczPLY5Zaty/Ut7UdUh5ID0rJ1oD9ekJY=";
    passthru.comfyui.installPaths = [ "checkpoints" ];
  };
}
