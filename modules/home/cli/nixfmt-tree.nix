{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      nixfmt
      nixfmt-tree
    ];
  };
}
