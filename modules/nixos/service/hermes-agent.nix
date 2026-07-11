{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.sops-nix.enable;
in
{
  imports = [
    inputs.hermes-agent.nixosModules.default
  ];
  config = lib.mkIf enableModule {
    sops.secrets."hermes.env" = {
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
      settings = {
        model = {
          provider = "opencode-go";
          default = "deepseek-v4-flash";
        };
        auxiliary = {
          vision = {
            provider = "llama.cpp";
            model = "qwen3.6-35b-a3b";
            base_url = "http://192.168.1.100:8080";
            api_key = "1";
          };
          title_generation = {
            provider = "opencode-go";
            model = "deepseek-v4-flash";
          };
        };
        web.search_backend = "searxng";
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
