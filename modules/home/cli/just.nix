{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      just
    ];
  };
}
