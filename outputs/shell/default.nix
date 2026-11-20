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
      nixd
      nixfmt
      nixfmt-tree
      rom
      sops
    ];
  };
}
