{
  ...
}:
{
  config = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = false;
      enableFishIntegration = true;
    };
  };
}
