{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  inherit (opts.editor.vscode) enableExtensions;
  enableModule = (lib.elem "markdown" enableExtensions) || (lib.elem "all" enableExtensions);
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
