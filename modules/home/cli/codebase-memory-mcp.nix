{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      codebase-memory-mcp
    ];
  };
}
