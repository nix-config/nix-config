{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.tool.mission-center or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      mission-center
    ];
  };
}
