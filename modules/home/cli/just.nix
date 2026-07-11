{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.cli.just.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      just
    ];
  };
}
