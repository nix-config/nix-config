{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  enableModule = opts.service.daed.enable;
in
{
  imports = [
    inputs.daeuniverse.nixosModules.daed
  ];
  config = lib.mkIf enableModule {
    services.daed = {
      enable = true;
      package = inputs.daeuniverse.packages.${pkgs.stdenv.hostPlatform.system}.daed;
      openFirewall = {
        enable = true;
        port = 12345;
      };
      configDir = "/etc/daed";
      listen = "127.0.0.1:2023";
    };
  };
}
