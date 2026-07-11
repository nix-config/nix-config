{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.cli.nixfmt-tree.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      nixfmt
      nixfmt-tree
    ];
  };
}
