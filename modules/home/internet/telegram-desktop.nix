{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.internet.telegram-desktop or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
