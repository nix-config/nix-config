{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.nix-ld.enable;
in
{
  config = lib.mkIf enableModule {
    programs.nix-ld.enable = true;
  };
}
