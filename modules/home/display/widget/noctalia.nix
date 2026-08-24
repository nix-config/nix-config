{
  lib,
  opts,
  ...
}:
let
  enableModule =
    (lib.elem "noctalia" opts.display.widget.enabledWidgets) && opts.display.desktop.enable;
in
{
  config = lib.mkIf enableModule {
    programs.noctalia = {
      enable = true;
      settings = {
        bar = {
          order = [ "default" ];
          default = {
            concave_edge_corners = false;
            font_family = "FiraCode Nerd Font Mono";
            margin_edge = 10;
            margin_ends = 10;
            padding = 16;
            thickness = 32;
            widget_spacing = 8;
          };
        };
        theme = {
          mode = "dark";
          source = "wallpaper";
          generator = "m3-content";
        };
      };
    };
  };
}
