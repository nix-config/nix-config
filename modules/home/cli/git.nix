{
  opts,
  ...
}:
let
  cfg = opts.cli.git;
  user = cfg.user;
  nvimIsEnabled = opts.editor.nixvim.enable;
in
{
  config = {
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
