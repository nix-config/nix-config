{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.tmux.enable;
in
{
  config = lib.mkIf enableModule {
    programs.tmux = {
      enable = true;
    };
  };
}
