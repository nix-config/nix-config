{
  pkgSets,
  ...
}:
{
  config = {
    home.packages = with pkgSets.pkgs-nixos-unstable; [
      biu
    ];
  };
}
