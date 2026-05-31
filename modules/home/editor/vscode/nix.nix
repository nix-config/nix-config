{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions.nix or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
      # Nix 语法支持
      jnoortheen.nix-ide
      # direnv 支持
      mkhl.direnv
    ];
  };
}
