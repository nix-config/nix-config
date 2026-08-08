{
  lib,
  opts,
  ...
}:
let
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
          (lib.optionalAttrs btopIsEnabled {
            top = "btop";
          })
          (lib.optionalAttrs nixvimIsEnabled {
            vi = "nvim";
            vim = "nvim";
          })
        ];
      };
    };
  };
}
