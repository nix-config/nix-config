{
  lib,
  pkgs,
  opts,
  ...
}:
let
  inherit (opts.cli.mcp) enabledMcps;
  enableModule = (lib.elem "codebase-memory-mcp" enabledMcps) || (lib.elem "all" enabledMcps);
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      codebase-memory-mcp
    ];
    programs.mcp.servers."codebase-memory-mcp" = {
      enabled = true;
      command = "${lib.getExe pkgs.codebase-memory-mcp}";
      type = "local";
    };
  };
}
