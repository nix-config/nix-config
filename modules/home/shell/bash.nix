{
  lib,
  opts,
  ...
}:
let
  cfg = opts.shell.bash or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      # 不添加任何额外功能保证鲁棒性
      bash.enable = true;
      # 启用 fzf 集成
      fzf.enableBashIntegration = false;
      # 启用 eza 集成
      eza.enableBashIntegration = false;
      # 启用 yazi 集成
      yazi.enableBashIntegration = false;
      # 启用 direnv 集成
      direnv.enableBashIntegration = false;
      # 启用 zellij 集成
      zellij.enableBashIntegration = false;
      # 启用 starship 集成
      starship.enableBashIntegration = false;
    };
  };
}
