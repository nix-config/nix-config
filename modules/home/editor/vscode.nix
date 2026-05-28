{
  lib,
  pkgs,
  opts,
  config,
  ...
}:
let
  cfg = opts.editor.vscode or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
  configPath = "${opts.nixConfigPath}/modules/config";
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode = {
      enable = true;
      profiles.default.extensions =
        with pkgs.vscode-extensions;
        [
          # ========== 外观 ==========
          # 中文界面语言包
          ms-ceintl.vscode-language-pack-zh-hans
          # Material 风格图标主题
          pkief.material-icon-theme
          # ========== Markdown ==========
          # Markdown 预览
          shd101wyy.markdown-preview-enhanced
          # Markdown 语法规范检查
          davidanson.vscode-markdownlint
          # ========== JavaScript / TypeScript ==========
          # ESLint 集成
          dbaeumer.vscode-eslint
          # Tailwind CSS 语法支持
          bradlc.vscode-tailwindcss
          # Svelte 框架支持
          svelte.svelte-vscode
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            # Ripple 框架辅支持
            name = "ripple-ts-vscode-plugin";
            publisher = "Ripple-TS";
            version = "2.0.18";
            sha256 = "sha256-6pV5uExZ51AcQdUKq/CtzjU6vynnkm3xi05y1S9iyx0=";
          }
        ]
        ++ [
          # ========== Python ==========
          # Python 语言支持
          ms-python.python
          # Python 调试器
          ms-python.debugpy
          # Python 高性能语言服务器
          ms-python.vscode-pylance
          # Black 代码格式化工具
          ms-python.black-formatter
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            # Python 环境管理
            name = "vscode-python-envs";
            publisher = "ms-python";
            version = "1.33.2026052801";
            sha256 = "sha256-/hndcyNeMuHoSOiEp0q3xwRQbAdkoiyHNrovEvUT8O8=";
          }
          {
            # Manim 动画侧边实时预览
            name = "manim-sideview";
            publisher = "Rickaym";
            version = "0.3.1";
            sha256 = "sha256-TZs0KCBfVbueu6AGdP1OL8DTQkWiPWh1zcFBdHU+Gwc=";
          }
        ]
        ++ [
          # ========== 其他语言支持 ==========
          # Nix 语言支持
          jnoortheen.nix-ide
          # TOML 语言支持
          tamasfe.even-better-toml
          # YAML 语言支持
          redhat.vscode-yaml
          # Jinja 语言支持
          wholroyd.jinja
          # Rust 语言支持
          rust-lang.rust-analyzer
          # Go 语言支持
          golang.go
          # ========== 容器与远程开发 ==========
          # 开发容器支持
          ms-azuretools.vscode-containers
          # Docker 镜像, 容器管理
          ms-azuretools.vscode-docker
          # 通过 SSH 连接远程主机
          ms-vscode-remote.remote-ssh
          # SSH 配置编辑支持
          ms-vscode-remote.remote-ssh-edit
          # 远程资源管理器视图
          ms-vscode.remote-explorer
          # ========== 实用工具 ==========
          # Prettier 多语言格式化
          esbenp.prettier-vscode
          # Git 提交图可视化
          mhutchie.git-graph
          # 代码翻译
          w88975.code-translate
          # 行内错误高亮
          usernamehw.errorlens
          # 缩进层次彩虹色标识
          oderwat.indent-rainbow
          # 文件路径智能补全
          christian-kohler.path-intellisense
          # 生成美观的代码截图
          adpyke.codesnap
          # 十六进制编辑器
          ms-vscode.hexeditor
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            # 系统监控
            name = "monitor-pro";
            publisher = "nexmoe";
            version = "0.7.5";
            sha256 = "sha256-Q38GkZyouXg58YFvrlaoT9Km0wGd8VFPPSPfvaFE1cs=";
          }
          {
            # 行号区域预览图片, 颜色等
            name = "vscode-gutter-preview";
            publisher = "kisstkondoros";
            version = "0.32.2";
            sha256 = "sha256-JIr4UGuwy9Z5oH8D8elGMBGP8s40pYLCEZGmJAO5Ga0=";
          }
          {
            # 阅读 EPUB 电子书
            name = "epub-reader";
            publisher = "cweijan";
            version = "1.0.0";
            sha256 = "sha256-wundHVZ0GNcddIh1Af+fBobdKsswk+MMoFVnI7hjgTQ=";
          }
        ];
    };
    home.file = {
      ".vscode/argv.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/argv.json";
        force = true;
      };
      ".config/Code/User/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/settings.json";
        force = true;
      };
    };
  };
}
