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
      # 诊断信息显示配置, 控制 LSP 报错和警告的展示方式
      # 默认情况下 diagnostics 只在右下角消息栏显示,
      # 以下配置开启三种行内显示方式:
      diagnostic = {
        settings = {
          # 在每一行有错误的行尾直接显示错误信息文字, 例如:
          # let x: number = "hello"  (类型不匹配)
          virtual_text = true;
          # 在编辑器左侧 gutter 栏显示错误图标:
          # E 错误, W 警告, I 信息, H 提示
          signs = true;
          # 光标所在行的下方以虚拟行方式展开显示完整诊断信息
          # 需要 Neovim 0.10+, 效果类似于浮动窗口但嵌入在文本中
          virtual_lines = {
            current_line = true;
          };
          # 插入模式下不实时更新诊断, 退出插入模式后再刷新
          # 这样可以避免输入卡顿, 提升编辑流畅度
          update_in_insert = false;
        };
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
        # 语法高亮, 提供基于语法树的代码着色和增量解析等功能
        treesitter = {
          enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            nix
          ];
        };
        # LSP 支持, 提供代码补全和错误检查等功能
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
          };
        };
        # 配置按文件类型自动格式化
        conform-nvim = {
          enable = true;
          settings = {
            # 指定每种文件类型对应的格式化工具
            formatters_by_ft = {
              nix = [ "nixfmt" ];
            };
            # 配置保存时自动格式化
            format_on_save = {
              # 无对应 formatter 时回退到 LSP
              lsp_fallback = true;
            };
          };
        };
        # nvim-cmp: 自动补全引擎, 输入时弹出补全菜单
        # 这是一个高度可配置的补全框架, 支持多种补全源
        cmp = {
          enable = true;
          # 自动启用 sources 列表中已知的 nixvim 插件
          # 例如 sources 中有 nvim_lsp, 则自动启用 cmp-nvim-lsp 插件
          autoEnableSources = true;
          settings = {
            # 补全菜单窗口外观配置
            window = {
              completion = {
                # 补全菜单边框样式, "rounded" 圆角, "single" 单线, "double" 双线
                border = "rounded";
                # 使用浮窗高亮配色, 让菜单融入编辑器主题
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";
                # 显示滚动条 (候选词较多时)
                scrollbar = true;
                # 左右内边距, 让文字不贴边
                side_padding = 1;
              };
              documentation = {
                # 选中项文档浮窗的边框样式
                border = "rounded";
              };
            };
            # 补全源: 指定从哪里获取补全候选词
            sources = [
              # 来自 LSP 服务器的语义补全 (变量名, 函数名, 类型等)
              { name = "nvim_lsp"; }
              # 文件路径补全, 如 ./src/ 或 /usr/local/
              { name = "path"; }
              # 当前 buffer 和其他打开的 buffer 中的文本补全
              { name = "buffer"; }
              # 代码片段补全 (由 luasnip 提供)
              { name = "luasnip"; }
            ];
            # 快捷键映射
            mapping = {
              # Ctrl + e: 取消补全, 关闭菜单
              "<C-e>" = "cmp.mapping.abort()";
              # Enter: 确认选中的补全项 (没有选中时仍作为普通回车)
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              # Tab: 选择下一个补全项, 在 插入模式(i) 和 选择模式(s) 下生效
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              # Shift + Tab: 选择上一个补全项
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
          };
        };
        # cmp-nvim-lsp: 让 nvim-cmp 能够从 LSP 服务器获取补全
        # 开启后, LSP 返回的变量、函数、参数等会自动出现在补全菜单中
        cmp-nvim-lsp = {
          enable = true;
        };
        # LuaSnip: 代码片段引擎, 配合 nvim-cmp 提供片段补全
        # 支持自定义可展开的代码模板, 例如输入 for<Tab> 展开为 for 循环
        luasnip = {
          enable = true;
        };
        # lspkind: 在补全菜单中为每一项显示图标 (函数/变量/类/关键字等)
        # 图标使用 Nerd Font 字符集, 需终端支持 Nerd Font
        lspkind = {
          enable = true;
          cmp = {
            enable = true;
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
