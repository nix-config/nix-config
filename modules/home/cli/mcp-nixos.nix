{
  pkgs,
  inputs,
  ...
}:
let
  mcp-nixos = inputs.mcp-nixos.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  config = {
    home.packages = [
      mcp-nixos
    ];
  };
}
