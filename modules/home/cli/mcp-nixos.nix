{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      mcp-nixos
    ];
  };
}
