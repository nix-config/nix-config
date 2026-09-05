{
  lib,
  opts,
  ...
}:
let
  inherit (opts.hardware.networking)
    proxy
    hostName
    firewall
    networkmanager
    extraSettings
    ;
in
{
  config = {
    networking = lib.mkMerge [
      {
        inherit
          proxy
          hostName
          firewall
          networkmanager
          ;
      }
      extraSettings
    ];
  };
}
