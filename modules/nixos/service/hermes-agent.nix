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
    inputs.sops-nix.nixosModules.sops
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
          provider = "vllm";
          model = "qwen3.8-27b";
          base_url = "$" + "{VLLM_BASE_URL}";
          api_key = "$" + "{VLLM_API_KEY}";
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
