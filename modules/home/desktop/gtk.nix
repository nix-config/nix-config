{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.desktop or { };
  desktopNotEnable = (cfg.type or "none") == "none";
  desktopWslEnable = (cfg.type or "none") == "wsl";
  finallyEnable = !desktopNotEnable && !desktopWslEnable;
in
{
  config = lib.mkIf finallyEnable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
