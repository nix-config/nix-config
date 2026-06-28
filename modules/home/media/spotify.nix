{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.media.spotify or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
