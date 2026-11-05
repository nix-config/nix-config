{
  inputs,
  functions,
  ...
}:
let
  system = "x86_64-linux";
  inherit (functions.mk.pkgSets system inputs) pkgs;
in
{
  ${system}.default = pkgs.mkShell {
    packages = with pkgs; [
      flake-show-ng
      just
      just-lsp
      nix-output-monitor
      nixd
      nixfmt
      nixfmt-tree
      sops
    ];
  };
}
