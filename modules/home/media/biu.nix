{
  pkgs,
  inputs,
  ...
}:
let
  # 用 NUR overlay 叠加到项目的 pkgs 上 (含 allowUnfree)
  pkgs-nur = pkgs.extend inputs.nur.overlays.default;
in
{
  config = {
    home.packages = with pkgs-nur; [
      nur.repos.lonerOrz.biu
    ];
  };
}
