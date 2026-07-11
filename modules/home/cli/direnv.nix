{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.direnv.enable;
in
{
  config = lib.mkIf enableModule {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
