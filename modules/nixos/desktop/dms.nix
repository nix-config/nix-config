{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.desktop.dms or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
in
{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
  ];
  config = lib.mkIf finallyEnable {
    programs = {
      dank-material-shell = {
        enable = true;
        systemd = {
          # 创建 systemd 服务单元
          enable = false;
          # 是否自动重启该服务以应用更改
          restartIfChanged = true;
        };
        # 启用系统监控小部件(dgop)
        enableSystemMonitoring = true;
        # 启用 VPN 管理小部件
        # enableVPN = true;
        # 启用基于壁纸的动态主题生成(matugen)
        enableDynamicTheming = true;
        # 启用音频可视化小部件(cava)
        enableAudioWavelength = true;
        # 启用日历事件集成(khal)
        # enableCalendarEvents = true;
        # 启用剪贴板历史粘贴功能(wtype)
        enableClipboardPaste = true;
      };
    };
  };
}
