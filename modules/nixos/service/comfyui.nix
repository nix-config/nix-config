{
  lib,
  opts,
  inputs,
  pkgSets,
  ...
}:
let
  # TODO: NixOS/nixpkgs#550095
  inherit (inputs) nixpkgs-knightfemale;
  comfyuiModule = "${nixpkgs-knightfemale}/nixos/modules/services/misc/comfyui.nix";
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  inherit (opts.service.comfyui)
    extraArgs
    listen
    models
    port
    ;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
in
{
  disabledModules = [ "services/misc/comfyui.nix" ];
  imports = [
    comfyuiModule
  ];
  config = lib.mkIf enableModule (
    lib.mkMerge [
      {
        documentation.nixos = {
          extraModules = [ comfyuiModule ];
          extraModuleSources = [ nixpkgs-knightfemale ];
          checkRedirects = false;
        };
        services.comfyui = {
          enable = true;
          package = pkgSets.pkgs-knightfemale.comfyui;
          acceleration = "cuda";
          inherit
            extraArgs
            listen
            models
            port
            ;
          # customNodes = with pkgs.comfyui-custom-nodes; [
          #   comfyui-crystools
          #   comfyui-manager
          #   comfyui-pythongosssss-custom-scripts
          #   comfyui-rgthree
          #   comfyui-ultimatesdupscale
          # ];
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
