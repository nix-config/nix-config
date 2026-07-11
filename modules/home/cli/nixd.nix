{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.cli.nixd.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      nixd
    ];
  };
}
