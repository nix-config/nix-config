{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.hardware.disk;
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices.disk = cfg;
}
