{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.fastfetch or { };
  finallyEnable = cfg.enable or false;
  desktopNotEnable = (opts.desktop.type or "") == "";
  desktopWslEnable = (opts.desktop.type or "") == "wsl";
  useFastfetchMinimal = desktopNotEnable || desktopWslEnable;
  # 配置中使用的变量和函数
  width = 64; # 第二列的宽度, 可自由调整
  esc = builtins.fromJSON ''"\u001b"'';
  line = lib.strings.replicate width "─";
  forward = count: "${esc}[${builtins.toJSON count}C";
  backward = count: "${esc}[${builtins.toJSON count}D";
  mkTop = color: nameColor: name: {
    type = "custom";
    key = "{#${color}}╭───────────────┬${line}╮${backward (width + 14)}{#keys}";
    "format" = "{#${nameColor}}${name} ";
  };
  mkEntry = color: name: type: {
    inherit type;
    key = "{#${color}}│ {icon}  ${name}│${forward width}│${backward (width + 1)}{#keys}";
  };
  mkFoot = color: {
    type = "custom";
    key = "{#${color}}╰───────────────┴${line}╯";
  };
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      fastfetch = {
        enable = true;
        package = lib.mkIf useFastfetchMinimal pkgs.fastfetch-unwrapped;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
          logo = {
            type = "none";
          };
          display = {
            # 分隔符
            separator = " ";
            size = {
              # 使用 KB/MB/GB
              binaryPrefix = "si";
              # 显示小数位数
              ndigits = 1;
            };
            percent = {
              # 百分比显示模式
              type = 2;
            };
            bar = {
              # 已用部分字符
              char.elapsed = "■";
              # 未用部分字符
              char.total = " ";
            };
          };
          modules = [
            # 系统
            (mkTop "blue" "bright_blue" "System")
            (mkEntry "blue" "BIOS       " "bios")
            (mkEntry "blue" "BootMgr    " "bootmgr")
            (mkEntry "blue" "InitSystem " "initsystem")
            (mkEntry "blue" "OS         " "os")
            (mkEntry "blue" "Kernel     " "kernel")
            (mkEntry "blue" "Packages   " "packages")
            (mkEntry "blue" "Locale     " "locale")
            (mkEntry "blue" "Local IP   " "localip")
            (mkEntry "blue" "Public IP  " "publicip")
            (
              mkEntry "blue" "OS Age     " "disk"
              // {
                condition = {
                  "!system" = "macOS";
                };
                keyIcon = "";
                folders = "/";
                format = "{create-time:10} [{days} days]";
              }
            )
            (
              mkEntry "blue" "OS Age     " "disk"
              // {
                condition = {
                  system = "macOS";
                };
                keyIcon = "";
                folders = "/System/Volumes/VM";
                format = "{create-time:10} [{days} days]";
              }
            )
            (mkFoot "blue")
            # 硬件
            (mkTop "cyan" "bright_cyan" "Hardware")
            (mkEntry "cyan" "Host       " "host")
            (mkEntry "cyan" "Chassis    " "chassis")
            (mkEntry "cyan" "Board      " "board")
            (mkEntry "cyan" "TPM        " "tpm")
            (mkEntry "cyan" "CPU        " "cpu" // { showPeCoreCount = true; })
            (mkEntry "cyan" "GPU        " "gpu")
            (mkEntry "cyan" "RAM        " "memory")
            (mkEntry "cyan" "Swap       " "swap")
            (mkEntry "cyan" "Disk       " "disk")
            (mkEntry "cyan" "ZPool      " "zpool")
            (mkEntry "cyan" "Display    " "display")
            (mkEntry "cyan" "Camera     " "camera")
            (mkFoot "cyan")
            # 终端
            (mkTop "yellow" "bright_yellow" "Terminal")
            (mkEntry "yellow" "Shell      " "shell")
            (mkEntry "yellow" "Terminal   " "terminal")
            (mkEntry "yellow" "Editor     " "editor")
            (mkEntry "yellow" "Theme      " "terminaltheme")
            (mkEntry "yellow" "Font       " "terminalfont")
            (mkFoot "yellow")
            # 桌面
            (mkTop "green" "bright_green" "Desktop")
            (mkEntry "green" "G-Driver   " "gpu" // { format = "{driver}"; })
            (mkEntry "green" "Vulkan     " "vulkan")
            (mkEntry "green" "OpenGL     " "opengl")
            (mkEntry "green" "OpenCL     " "opencl")
            (mkEntry "green" "Login      " "lm")
            (mkEntry "green" "Desktop    " "de")
            (mkEntry "green" "WM         " "wm")
            (mkEntry "green" "Theme      " "theme")
            (mkEntry "green" "WM Theme   " "wmtheme")
            (mkEntry "green" "Icons      " "icons")
            (mkEntry "green" "Cursor     " "cursor")
            (mkEntry "green" "Wallpaper  " "wallpaper")
            (mkFoot "green")
            # 状态
            (mkTop "magenta" "bright_magenta" "Status")
            (mkEntry "magenta" "Datetime   " "datetime")
            (mkEntry "magenta" "Weather    " "weather" // { timeout = 1000; })
            (mkEntry "magenta" "Users      " "users" // { myselfOnly = true; })
            (mkEntry "magenta" "Uptime     " "uptime")
            (mkEntry "magenta" "Power      " "poweradapter")
            (mkEntry "magenta" "Battery    " "battery")
            (mkEntry "magenta" "Wifi       " "wifi")
            (mkEntry "magenta" "Bluetooth  " "bluetooth")
            (mkEntry "magenta" "BT Radio   " "bluetoothradio")
            (mkEntry "magenta" "Brightness " "brightness")
            (mkEntry "magenta" "Sound      " "sound")
            (mkEntry "magenta" "Media      " "media")
            (mkFoot "magenta")
          ];
        };
      };
    };
  };
}
