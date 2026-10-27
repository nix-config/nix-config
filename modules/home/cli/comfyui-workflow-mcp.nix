{
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.nur-knightfemale.homeModules.comfyui-workflow-mcp ];
  config = {
    sops.secrets."comfyui-workflow-mcp.toml" = {
      sopsFile = ../../../secrets/comfyui-workflow-mcp.enc;
      format = "binary";
      mode = "0400";
    };
    programs.comfyui-workflow-mcp = {
      enable = true;
      settings.paths.env_file = config.sops.secrets."comfyui-workflow-mcp.toml".path;
    };
  };
}
