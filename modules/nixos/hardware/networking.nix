{
  lib,
  opts,
  ...
}:
let
  cfg = opts.hardware.networking;
  inherit (cfg) proxy;
  inherit (cfg) hostName;
  inherit (cfg) firewall;
  inherit (cfg) networkmanager;
  inherit (cfg) extraSettings;
in
{
  config = {
    networking = lib.mkMerge [
      {
        inherit proxy;
        inherit hostName;
        inherit firewall;
        inherit networkmanager;
      }
      extraSettings
    ];
  };
}
