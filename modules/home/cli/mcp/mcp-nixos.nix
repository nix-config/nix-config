{
  lib,
  pkgs,
  opts,
  ...
}:
let
  inherit (opts.cli.mcp) enabledMcps;
  enableModule = (lib.elem "mcp-nixos" enabledMcps) || (lib.elem "all" enabledMcps);
  # TODO
  mcp-nixos = pkgs.mcp-nixos.overridePythonAttrs (old: {
    disabledTests = (old.disabledTests or [ ]) ++ [ "test_read_text_file" ];
  });
in
{
  config = lib.mkIf enableModule {
    programs.mcp.servers."mcp-nixos" = {
      enabled = true;
      command = "${lib.getExe mcp-nixos}";
      type = "local";
    };
  };
}
