{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.codebase-memory-mcp or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      codebase-memory-mcp
    ];
  };
}
