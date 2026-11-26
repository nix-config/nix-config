{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      biu
    ];
  };
}
