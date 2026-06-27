{
  lib,
  opts,
  ...
}:
let
  cfg = opts.shell.fish or { };
  finallyEnable = cfg.enable or false;
  batEnable = opts.cli.bat.enable or false;
  btopEnable = opts.cli.btop.enable or false;
  nixvimEnable = opts.editor.nixvim.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      fish = {
        enable = true;
        # 在交互式期间初始化调用的 shell 脚本代码
        interactiveShellInit =
          ""
          # 忽略问候
          + "set -g fish_greeting\n";
        # 命令别名
        shellAliases = lib.mkMerge [
          {
            rm = "rm -i";
          }
          (lib.optionalAttrs batEnable {
            cat = "bat";
          })
          (lib.optionalAttrs btopEnable {
            top = "btop";
          })
          (lib.optionalAttrs nixvimEnable {
            vi = "nvim";
            vim = "nvim";
          })
        ];
      };
      # 启用 fzf 集成
      fzf.enableFishIntegration = true;
      # 启用 eza 集成
      eza.enableFishIntegration = true;
      # 启用 yazi 集成
      yazi.enableFishIntegration = true;
      # 启用 direnv 集成
      direnv.enableFishIntegration = true;
      # 启用 zellij 集成 (显式不启用)
      zellij.enableFishIntegration = false;
      # 启用 starship 集成
      starship.enableFishIntegration = true;
    };
  };
}
