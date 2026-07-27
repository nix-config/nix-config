{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  inherit (opts.service.comfyui) extraFlags models;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
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
          inherit extraFlags;
          customNodes = with pkgs.comfyuiPackages; [
            comfyui-crystools
            comfyui-pythongosssss-custom-scripts
            comfyui-rgthree
            comfyui-ultimatesdupscale
          ];
          models = map (model: pkgs.fetchResource model) models;
        };
      }
      (lib.optionalAttrs isWsl {
        systemd.services.comfyui = {
          environment.LD_LIBRARY_PATH = "/run/opengl-driver/lib";
          serviceConfig.DeviceAllow = [ "/dev/dxg rwm" ];
        };
      })
    ]
  );
}
