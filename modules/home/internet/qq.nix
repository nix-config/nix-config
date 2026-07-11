{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      qq
    ];
  };
}
