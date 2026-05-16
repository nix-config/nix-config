{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.comfyui or { };
  finallyEnable = cfg.enable or false;
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
    };
  };
}
