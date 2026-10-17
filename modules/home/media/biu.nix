{
  pkgSets,
  ...
}:
{
  config = {
    home.packages = with pkgSets.pkgs-knightfemale; [
      biu
    ];
  };
}
