{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.editor.nixvim or { };
  finallyEnable = cfg.enable or false;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  config = lib.mkIf finallyEnable {
    programs.nixvim = {
      enable = true;
      nixpkgs.source = pkgs.path;
      highlight = {
        Normal.bg = "NONE";
      };
      plugins = {
        # 为文件类型提供图标支持
        web-devicons.enable = true;
        # 文件资源管理器
        neo-tree = {
          enable = true;
          settings = {
            # 当 neo-tree 是最后一个窗口时, 关闭它会直接退出 Neovim
            close_if_last_window = true;
            filesystem = {
              # 启动跟踪, 自动展开当前文件目录
              follow_current_file = {
                enabled = true;
                # 切换文件后, 之前的目录也不会折叠
                leave_dirs_open = true;
              };
              filtered_items = {
                # 隐藏以 . 开头的文件和目录
                hide_dotfiles = false;
              };
            };
          };
        };
      };
      autoCmd = [
        # 启动时自动打开文件资源管理器
        {
          event = "VimEnter";
          command = "Neotree";
        }
      ];
    };
  };
}
