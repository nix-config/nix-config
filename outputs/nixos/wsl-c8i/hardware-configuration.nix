{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.nixos-wsl.nixosModules.default ];
  wsl = {
    enable = true;
    defaultUser = "admin";
    useWindowsDriver = true;
    extraBin = lib.mkAfter [
      { src = "${pkgs.coreutils}/bin/true"; }
    ];
  };
}
