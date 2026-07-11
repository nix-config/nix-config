{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.cli.codebase-memory-mcp.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      codebase-memory-mcp
    ];
  };
}
