{
  lib,
  opts,
  ...
}:
let
  batIsEnabled = opts.cli.bat.enable;
  btopIsEnabled = opts.cli.btop.enable;
  nixvimIsEnabled = opts.editor.nixvim.enable;
in
{
  config = {
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
          (lib.optionalAttrs batIsEnabled {
            cat = "bat";
          })
          (lib.optionalAttrs btopIsEnabled {
            top = "btop";
          })
          (lib.optionalAttrs nixvimIsEnabled {
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
