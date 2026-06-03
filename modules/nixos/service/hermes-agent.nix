{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.cli.hermes-agent or { };
  enableSopsNix = opts.service.sops-nix.enable or false;
  finallyEnable = cfg.enable or false && enableSopsNix;
in
{
  imports = [
    inputs.hermes-agent.nixosModules.default
  ];
  config = lib.mkIf finallyEnable {
    sops.secrets."hermes.env" = lib.mkIf enableSopsNix {
      sopsFile = ../../../secrets/hermes.env;
      format = "dotenv";
      owner = "hermes";
      mode = "0600";
    };
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
      settings = {
        model.default = "deepseek-v4-pro";
        gateway.platforms.qqbot.enabled = true;
      };
      environmentFiles = [ config.sops.secrets."hermes.env".path ];
    };
  };
}
