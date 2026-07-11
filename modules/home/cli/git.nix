{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.git;
  enableModule = cfg.enable;
  user = cfg.user;
  nvimIsEnabled = opts.editor.nixvim.enable;
in
{
  config = lib.mkIf enableModule {
    programs.git = {
      enable = true;
      settings = {
        inherit user;
        init.defaultBranch = "master";
        core.editor = if nvimIsEnabled then "nvim" else "nano";
      };
    };
  };
}
