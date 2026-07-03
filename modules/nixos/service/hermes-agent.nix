{
  lib,
  opts,
  config,
  inputs,
  pkgSets,
  ...
}:
let
  cfg = opts.service.hermes-agent or { };
  enableSopsNix = opts.service.sops-nix.enable or false;
  finallyEnable = (cfg.enable or false) && enableSopsNix;
  byterover-cli = pkgSets.pkgs-knightfemale-byterover-cli.byterover-cli;
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
      extraDependencyGroups = [
        "feishu"
      ];
      extraPackages = [
        byterover-cli
      ];
      settings = {
        model = {
          provider = "opencode-go";
          default = "deepseek-v4-flash";
        };
        auxiliary = {
          vision = {
            provider = "opencode-go";
            model = "mimo-v2.5";
          };
          title_generation = {
            provider = "opencode-go";
            model = "deepseek-v4-flash";
          };
        };
        web.search_backend = "searxng";
        memory.provider = "byterover";
        gateway.platforms = {
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
      environmentFiles = [
        config.sops.secrets."hermes.env".path
      ];
    };
  };
}
