{
  lib,
  pkgs,
  opts,
  ...
}:
let
  enableModule = opts.cli.sops.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      sops
    ];
  };
}
