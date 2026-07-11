{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.eza.enable;
in
{
  config = lib.mkIf enableModule {
    programs.eza = {
      enable = true;
    };
  };
}
