{
  lib,
  opts,
  inputs,
  pkgSets,
  ...
}:
let
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  inherit (opts.service.comfyui) extraArgs models;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
in
{
  disabledModules = [ "services/misc/comfyui.nix" ];
  imports = [
    "${inputs.nixpkgs-comfyui}/nixos/modules/services/misc/comfyui.nix"
  ];
  config = lib.mkIf enableModule (
    lib.mkMerge [
      {
        services.comfyui = {
          enable = true;
          package = pkgSets.pkgs-comfyui.comfyui;
          acceleration = "cuda";
          listen = [ "0.0.0.0" ];
          port = 8188;
          inherit extraArgs;
          inherit models;
          customNodes = with pkgSets.pkgs-comfyui.comfyui-custom-nodes; [
            # TODO
            # comfyui-crystools
            comfyui-manager
            # comfyui-pythongosssss-custom-scripts
            # comfyui-rgthree
            # comfyui-ultimatesdupscale
          ];
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
