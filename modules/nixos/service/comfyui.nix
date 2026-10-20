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
  package = pkgs.comfyui.override {
    python3 = pkgs.python3.override {
      packageOverrides = _final: prev: {
        # cuda-bindings 13.4.3 的 pyproject 要求 cython >=3.2.5,<3.3
        # 而 nixpkgs 默认 cython 是 3.3.0, 构建时会报 Unmet dependencies
        cuda-bindings = prev.cuda-bindings.override { cython = prev.cython_3_2; };
        # torch/triton/torchvision 换成预编译 CUDA wheel, 避免源码构建 CUDA torch
        torch = prev.torch-bin;
        triton = prev.triton-bin;
        torchvision = prev.torchvision-bin;
        # -bin 属性本身也固定, 保证包集内部 torch-bin 等解析一致
        torch-bin = prev.torch-bin;
        triton-bin = prev.triton-bin;
        torchvision-bin = prev.torchvision-bin;
      };
    };
  };
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
          inherit package;
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
