{
  lib,
  opts,
  pkgSets,
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
      command = "${lib.getExe pkgSets.pkgs-nixos-unstable.mcp-nixos}";
      type = "local";
    };
  };
}
