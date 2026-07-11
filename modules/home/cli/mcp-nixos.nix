{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  enableModule = opts.cli.mcp-nixos.enable;
  mcp-nixos = inputs.mcp-nixos.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  config = lib.mkIf enableModule {
    home.packages = [
      mcp-nixos
    ];
  };
}
