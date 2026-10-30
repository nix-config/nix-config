local mainMod = "SUPER"
local opts = require("options")

-- ========== 显示器 ==========
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

-- ========== 环境变量 ==========
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ========== 外观与视觉 ==========
hl.config({
  -- 布局
  general = {
    -- 窗口内边距
    gaps_in = 5,
    -- 窗口外边距
    gaps_out = 10,
    -- 窗口边框大小
    border_size = 2,
    -- 边框颜色
    col = {
      -- 活动窗口边框颜色 (渐变)
      active_border = {
        colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
        angle = 45,
      },
      -- 非活动窗口边框颜色
      inactive_border = "rgba(ffa5d2ee)",
    },
    -- 是否可以通过拖拽边框调整窗口大小
    resize_on_border = false,
    -- 启用屏幕撕裂用于减少游戏中的延迟或抖动
    allow_tearing = false,
    -- 窗口布局
    layout = "scrolling",
  },
  -- 视觉效果
  decoration = {
    -- 窗口圆角大小
    rounding = 10,
    rounding_power = 2,
    -- 窗口透明度: 1.0 = 不透明, 0.0 = 完全透明
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    -- 窗口阴影
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
    -- 模糊效果
    blur = {
      enabled = true,
      -- 模糊半径
      size = 2,
      -- 采样次数
      passes = 3,
      -- 噪点纹理
      noise = 0.05,
      -- 饱和度
      vibrancy = 0.1696,
    },
  },
  -- 动画
  animations = { enabled = true },
  -- 水平平铺布局
  dwindle = {
    preserve_split = true,
  },
  -- 垂直平铺布局
  master = {
    new_status = "master",
  },
  -- 杂项
  misc = {
    -- 设置为 0 或 1 可禁用动漫吉祥物壁纸
    force_default_wallpaper = 1,
    -- 如果设置为 true, 则禁用随机显示的 Hyprland 标志/动漫女孩背景
    disable_hyprland_logo = true,
  },
  -- 输入
  input = {
    -- 键盘布局
    kb_layout = "us, cn",
    -- 键盘变体
    kb_variant = "",
    -- 键盘型号
    kb_model = "",
    -- 键盘选项
    kb_options = "",
    -- 键盘规则
    kb_rules = "",
    -- 鼠标移动时焦点跟随: 0=禁用 1=仅输出 2=完全跟随
    follow_mouse = 1,
    -- 鼠标灵敏度: -1.0 到 1.0, 0 表示不修改
    sensitivity = 0,
    -- 触摸板设置
    touchpad = {
      -- 自然滚动方向
      natural_scroll = true,
    },
  },
})

-- ========== 动画曲线 ==========
-- 格式: 名称, X0, Y0, X1, Y1
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- ========== 动画 ==========
-- 格式: 名称, 开关, 速度, 曲线, [样式]
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4.1,
  bezier = "easeOutQuint",
  style = "popin 87%",
})
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 1.49,
  bezier = "linear",
  style = "popin 87%",
})
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "easeOutQuint",
  style = "fade",
})
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 1.94,
  bezier = "almostLinear",
  style = "fade",
})
hl.animation({
  leaf = "workspacesIn",
  enabled = true,
  speed = 1.21,
  bezier = "almostLinear",
  style = "fade",
})
hl.animation({
  leaf = "workspacesOut",
  enabled = true,
  speed = 1.94,
  bezier = "almostLinear",
  style = "fade",
})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- ========== 快捷键绑定 ==========
-- exec 类绑定: 命令为空时跳过, 避免执行空命令
local function bindExec(key, cmd, bindOpts)
  if cmd == "" then
    return
  end
  hl.bind(key, hl.dsp.exec_cmd(cmd), bindOpts)
end
-- 打开终端
bindExec(mainMod .. " + Q", opts.terminal)
-- 打开系统活动监控器
bindExec(mainMod .. " + T", opts.top)
-- 打开文件管理器
bindExec(mainMod .. " + E", opts.file_manager)
-- 打开程序启动菜单
bindExec(mainMod .. " + R", opts.menu)
-- 退出 Hyprland
bindExec(
  mainMod .. " + M",
  "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
)
-- 关闭窗口
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- 切换浮动窗口
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- 移动焦点 (方向键): 走 scrolling 布局消息, 与 layoutmsg focus 等价
hl.bind(mainMod .. " + left", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + right", hl.dsp.layout("focus r"))
hl.bind(mainMod .. " + up", hl.dsp.layout("focus u"))
hl.bind(mainMod .. " + down", hl.dsp.layout("focus d"))
-- 使用数字键切换工作区 (Super + 数字) / 移动窗口过去 (Super + Shift + 数字)
for i = 1, 10 do
  local key = tostring(i % 10)
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end
-- 使用鼠标滚轮在垂直方向滚动工作区 (Super + 滚轮)
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
-- 增加 / 减小当前窗口列宽度 10% (Super + + / -)
hl.bind(mainMod .. " + equal", hl.dsp.layout("colresize +0.1"))
hl.bind(mainMod .. " + minus", hl.dsp.layout("colresize -0.1"))
-- 将当前列与左右邻居交换 (Super + CTRL + ←/→)
hl.bind(mainMod .. " + CTRL + left", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.layout("swapcol r"))
-- 鼠标拖拽移动 / 调整窗口大小: Super + 左键/右键拖拽
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- 笔记本电脑多媒体键: 音量调节 (按住连续触发)
bindExec("XF86AudioRaiseVolume", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", {
  locked = true,
  repeating = true,
})
bindExec("XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", {
  locked = true,
  repeating = true,
})
bindExec("XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", {
  locked = true,
  repeating = true,
})
bindExec("XF86AudioMicMute", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", {
  locked = true,
  repeating = true,
})
-- 屏幕亮度调节
bindExec("XF86MonBrightnessUp", "brightnessctl -e4 -n2 set 5%+", {
  locked = true,
  repeating = true,
})
bindExec("XF86MonBrightnessDown", "brightnessctl -e4 -n2 set 5%-", {
  locked = true,
  repeating = true,
})
-- 播放器控制 (需要 playerctl)
bindExec("XF86AudioNext", "playerctl next", { locked = true })
bindExec("XF86AudioPause", "playerctl play-pause", { locked = true })
bindExec("XF86AudioPlay", "playerctl play-pause", { locked = true })
bindExec("XF86AudioPrev", "playerctl previous", { locked = true })
-- 截图快捷键 — 按 shell 分支
if opts.noctalia then
  -- 区域截图到剪贴板 (PrintScreen)
  bindExec("Print", opts.screenshot .. " screenshot-region")
elseif opts.dms then
  -- 区域截图到剪贴板 (PrintScreen)
  bindExec("Print", opts.screenshot .. " region --no-file")
  -- 区域截图保存到文件 (CTRL + PrintScreen)
  bindExec("CTRL + Print", opts.screenshot .. " region --dir ~/Pictures/Screenshots")
end

-- ========== 自启动 ==========
if #opts.startup > 0 then
  hl.on("hyprland.start", function()
    for _, cmd in ipairs(opts.startup) do
      hl.exec_cmd(cmd)
    end
  end)
end

-- ========== 窗口和工作区规则 ==========
-- 忽略所有应用的最大化请求
hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})
-- 修复 XWayland 拖拽问题
hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})
-- Hyprland-run 启动器窗口规则
hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move = "20 monitor_h-120",
  float = true,
})
-- 全局禁用 keyboard-shortcuts-inhibit
-- 任何窗口都无法暂停本机的 SUPER/Alt/Ctrl 绑定
hl.window_rule({
  name = "no-shortcuts-inhibit-global",
  match = { class = ".*" },
  no_shortcuts_inhibit = true,
})
