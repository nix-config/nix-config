{
  config,
  lib,
  opts,
  ...
}:
let
  enableModule = (opts.display.desktop.type == "hyprland");
  # ========== 模块开关 ==========
  btopIsEnabled = config.programs.btop.enable;
  yaziIsEnabled = config.programs.yazi.enable;
  noctaliaIsEnabled = config.programs.noctalia.enable;
  footIsEnabled = config.programs.foot.enable;
  fcitx5IsEnabled = config.i18n.inputMethod.enable;
  kittyIsEnabled = config.programs.kitty.enable;
  dmsShellIsEnabled = (lib.elem "dms-shell" opts.display.widget.enabledWidgets);
  udiskieIsEnabled = opts.service.udiskie.enable;
  missionCenterIsEnabled = opts.tool.mission-center.enable;
  # ========== 程序 ==========
  # 终端模拟器
  terminalCmd =
    if kittyIsEnabled then
      "kitty"
    else if footIsEnabled then
      "foot"
    else
      "";
  # 系统活动监控器
  topCmd =
    if missionCenterIsEnabled then
      "missioncenter"
    else if btopIsEnabled then
      "${terminalCmd} -e btop"
    else
      "${terminalCmd} -e top";
  # 文件管理器
  fileManagerCmd = if yaziIsEnabled then "${terminalCmd} -e yazi" else "";
  # 程序启动菜单
  menuCmd =
    if noctaliaIsEnabled then
      "noctalia msg panel-toggle launcher"
    else if dmsShellIsEnabled then
      "dms ipc call spotlight toggle"
    else
      "";
  # 屏幕截图
  screenshotCmd =
    if noctaliaIsEnabled then
      "noctalia msg"
    else if dmsShellIsEnabled then
      "dms screenshot"
    else
      "";
  # ========== 自启动 ==========
  execOnce =
    # Noctalia
    lib.optional noctaliaIsEnabled "bash -lc 'exec noctalia'"
    # DankMaterialShell
    ++ lib.optional dmsShellIsEnabled "bash -lc 'exec dms run'"
    # 输入法
    ++ lib.optional fcitx5IsEnabled "fcitx5"
    # 自动挂载 U 盘
    ++ lib.optional udiskieIsEnabled "udiskie";
  # ========== 生成 options.lua ==========
  # 真实的 hyprland.lua 放在仓库里, 通过 require("options") 读取这些动态值
  toLua = lib.generators.toLua { };
  optionsLua = ''
    return {
      terminal = ${toLua terminalCmd},
      top = ${toLua topCmd},
      file_manager = ${toLua fileManagerCmd},
      menu = ${toLua menuCmd},
      screenshot = ${toLua screenshotCmd},
      noctalia = ${toLua noctaliaIsEnabled},
      dms = ${toLua dmsShellIsEnabled},
      startup = { ${lib.concatMapStringsSep ", " toLua execOnce} },
    }
  '';
in
{
  config = lib.mkIf enableModule {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "lua";
      systemd.enable = false;
    };
    home.file = {
      ".config/hypr/hyprland.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${opts.nixConfigPath}/modules/home/display/desktop/hyprland/config/hyprland.lua";
      ".config/hypr/options.lua".text = optionsLua;
    };
  };
}
