{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.service.hermes-agent or { };
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
      mode = "0660";
    };
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
      extraDependencyGroups = [ "feishu" ];
      settings = {
        model = {
          provider = "opencode-go";
          default = "deepseek-v4-pro";
        };
        auxiliary = {
          vision = {
            provider = "opencode-go";
            model = "qwen3.7-plus";
          };
          title_generation = {
            provider = "opencode-go";
            model = "deepseek-v4-flash";
          };
        };
        web.search_backend = "searxng";
        gateway.platforms = {
          # qqbot.enabled = true;
          feishu.enabled = true;
        };
        platform_toolsets = {
          feishu = [
            "web"
            "file"
            "todo"
            "memory"
            "skills"
            "vision"
            "clarify"
            "terminal"
            "delegation"
            "session_search"
          ];
        };
      };
      environmentFiles = [ config.sops.secrets."hermes.env".path ];
    };
  };
}
