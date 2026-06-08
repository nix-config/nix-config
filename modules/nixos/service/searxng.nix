{
  lib,
  opts,
  config,
  ...
}:
let
  cfg = opts.service.searxng or { };
  enableSopsNix = opts.service.sops-nix.enable or false;
  finallyEnable = cfg.enable or false && enableSopsNix;
in
{
  config = lib.mkIf finallyEnable {
    sops.secrets."searxng/env" = {
      sopsFile = ../../../secrets/searxng.env;
      format = "dotenv";
      owner = "searx";
      group = "searx";
      mode = "0400";
    };
    services.searx = {
      enable = true;

      # 使用 Redis 限流/缓存/会话存储
      redisCreateLocally = true;
      # 使用 uWSGI 运行生产模式
      configureUwsgi = true;
      uwsgiConfig = {
        socket = "/run/searx/searx.sock";
        chmod-socket = "660";
        # 直连 HTTP 端口 (不依赖 Nginx)
        http = ":8888";
      };
      environmentFile = config.sops.secrets."searxng/env".path;
      settings = {
        # 支持的请求格式
        search.formats = [
          "html"
          "json"
        ];
        server = {
          # 允许局域网访问
          bind_address = "0.0.0.0";
          # 是否限流
          limiter = false;
          # 引用环境变量
          secret_key = "$SEARXNG_SECRET";
        };
      };
    };
  };
}
