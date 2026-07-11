{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      nixd
    ];
  };
}
