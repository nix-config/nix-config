{
  lib,
  opts,
  vars,
  inputs,
  pkgSets,
  ...
}:
let
  # TODO: NixOS/nixpkgs#550095
  pkgs = pkgSets.pkgs-knightfemale;
  inherit (inputs) nixpkgs-knightfemale;
  comfyuiModule = "${nixpkgs-knightfemale}/nixos/modules/services/misc/comfyui.nix";
  gpuType = opts.hardware.graphics.type;
  enableModule = (gpuType == "nvidia") || (gpuType == "nvidia-open");
  inherit (opts.service.comfyui)
    customNodes
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
        services.comfyui = {
          enable = true;
          inherit
            extraArgs
            listen
            models
            port
            ;
          customNodes = map (name: (vars.comfyui.customNodes pkgs).${name}) customNodes;
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
