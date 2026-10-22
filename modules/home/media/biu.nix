{
  pkgs,
  inputs,
  ...
}:
{
  config = {
    home.packages = [
      inputs.nur-knightfemale.packages.${pkgs.stdenv.hostPlatform.system}.biu
    ];
  };
}
