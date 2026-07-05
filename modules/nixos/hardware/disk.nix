{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.hardware.disk or { };
  finallyEnable = cfg.enable or true;
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];
  config = lib.mkIf finallyEnable {
    disko.devices.disk = cfg;
  };
}
