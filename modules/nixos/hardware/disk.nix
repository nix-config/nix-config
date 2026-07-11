{
  opts,
  inputs,
  ...
}:
let
  devices = opts.hardware.disk.devices;
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];
  config = {
    disko.devices.disk = devices;
  };
}
