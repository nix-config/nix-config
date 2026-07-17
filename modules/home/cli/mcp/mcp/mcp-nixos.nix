{
  lib,
  pkgs,
  opts,
  ...
}:
let
  inherit (opts.cli.mcp) enabledMcps;
  enableModule = (lib.elem "mcp-nixos" enabledMcps) || (lib.elem "all" enabledMcps);
in
{
  config = lib.mkIf enableModule {
    programs.mcp.servers."mcp-nixos" = {
      enabled = true;
      command = "${lib.getExe pkgs.mcp-nixos}";
      type = "local";
    };
  };
}
