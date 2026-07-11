{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.fzf.enable;
in
{
  config = lib.mkIf enableModule {
    programs.fzf = {
      enable = true;
    };
  };
}
