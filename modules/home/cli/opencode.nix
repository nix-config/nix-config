{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.opencode or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.opencode = {
      enable = true;
      extraPackages = with pkgs; [
        bun
      ];
    };
  };
}
