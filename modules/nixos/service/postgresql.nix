{
  lib,
  opts,
  ...
}:
let
  firewall = opts.hardware.networking.firewall;
  inherit (opts.service.postgresql) instances;
in
{
  config = lib.mkIf opts.service.postgresql.enable {
    containers = builtins.listToAttrs (
      map (inst: {
        name = inst.name;
        value = {
          autoStart = true;
          privateNetwork = false;
          config = { ... }: {
            services.postgresql = {
              enable = true;
              settings.port = inst.port;
            };
            networking.firewall = firewall;
            system.stateVersion = opts.stateVersion;
          };
        };
      }) instances
    );
  };
}
