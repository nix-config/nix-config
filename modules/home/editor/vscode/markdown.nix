{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
  cfg = opts.editor.vscode.extensions.markdown or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # Markdown 预览
      shd101wyy.markdown-preview-enhanced
      # Markdown 语法规范检查
      davidanson.vscode-markdownlint
    ];
  };
}
