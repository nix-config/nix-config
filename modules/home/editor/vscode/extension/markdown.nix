{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  extensions = opts.editor.vscode.extensions;
  enableModule = lib.elem "markdown" extensions || lib.elem "all" extensions;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # Markdown 预览
      shd101wyy.markdown-preview-enhanced
      # Markdown 语法规范检查
      davidanson.vscode-markdownlint
    ];
  };
}
