inputs:
let
  inherit (lib) types;
  inherit (inputs.nixpkgs) lib;
  int = types.int;
  str = types.str;
  bool = types.bool;
  enum = types.enum;
  attrs = types.attrs;
  listOfStr = types.listOf types.str;
  attrsOfStr = types.attrsOf types.str;
  listOfAttrs = types.listOf types.attrs;
in
{
  count = int;
  system = enum [
    "i686-linux"
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];
  stateVersion = str;
  nixConfigPath = str;
  cli = {
    nix-ld = {
      enable = bool;
    };
    nix = {
      enable = bool;
      substituters = listOfStr;
      trusted-public-keys = listOfStr;
    };
    sudo-rs = {
      enable = bool;
    };
    bat = {
      enable = bool;
    };
    btop = {
      enable = bool;
    };
    direnv = {
      enable = bool;
    };
    eza = {
      enable = bool;
    };
    fastfetch = {
      enable = bool;
    };
    fzf = {
      enable = bool;
    };
    git = {
      enable = bool;
      user = {
        name = str;
        email = str;
      };
    };
    just = {
      enable = bool;
    };
    mcp-nixos = {
      enable = bool;
    };
    nh = {
      enable = bool;
    };
    nixd = {
      enable = bool;
    };
    nixfmt-tree = {
      enable = bool;
    };
    nvitop = {
      enable = bool;
    };
    opencode = {
      enable = bool;
    };
    sops = {
      enable = bool;
    };
    ssh = {
      enable = bool;
      enableSshSecrets = listOfStr;
    };
    starship = {
      enable = bool;
    };
    tmux = {
      enable = bool;
    };
    yazi = {
      enable = bool;
    };
    zellij = {
      enable = bool;
    };
  };
  container = {
    enable = bool;
    type = enum [
      "podman"
      "docker"
    ];
    dev-arch = {
      enable = bool;
    };
    portainer-agent = {
      enable = bool;
    };
  };
  desktop = {
    type = enum [
      "wsl"
      "none"
      "hyprland"
    ];
    dms = {
      enable = bool;
      softwareRenderingEnable = bool;
    };
  };
  editor = {
    nixvim = {
      enable = bool;
    };
    vscode = {
      enable = bool;
      extensions = {
        all = {
          enable = bool;
        };
        base = {
          enable = bool;
        };
        go = {
          enable = bool;
        };
        javascript = {
          enable = bool;
        };
        markdown = {
          enable = bool;
        };
        nix = {
          enable = bool;
        };
        python = {
          enable = bool;
        };
        reader = {
          enable = bool;
        };
        remote = {
          enable = bool;
        };
        rust = {
          enable = bool;
        };
      };
    };
  };
  environment = {
    qt-quick-backend = str;
  };
  hardware = {
    zram = {
      enable = bool;
    };
    bluetooth = {
      enable = bool;
    };
    graphics = {
      type = enum [
        "none"
        "amd"
        "nvidia"
      ];
    };
    kernel = {
      types = listOfStr;
      configs = attrsOfStr;
    };
    networking = attrs;
    disk = attrs;
    boot-loader = {
      type = enum [
        "wsl"
        "grub"
        "systemd-boot"
      ];
      efiSysMountPoint = str;
    };
  };
  i18n = {
    locale = enum [
      "en-us"
      "zh-cn"
    ];
  };
  internet = {
    firefox = {
      enable = bool;
    };
    qq = {
      enable = bool;
    };
    rustdesk = {
      enable = bool;
    };
    telegram-desktop = {
      enable = bool;
    };
    wechat = {
      enable = bool;
    };
  };
  media = {
    mpv = {
      enable = bool;
    };
    obs-studio = {
      enable = bool;
    };
    spotify = {
      enable = bool;
    };
  };
  service = {
    comfyui = {
      enable = bool;
    };
    daed = {
      enable = bool;
    };
    frp = {
      enable = bool;
      role = enum [
        "server"
        "client"
      ];
      proxies = listOfAttrs;
    };
    greetd = {
      enable = bool;
    };
    hermes-agent = {
      enable = bool;
    };
    libinput = {
      enable = bool;
    };
    logind = {
      enable = bool;
    };
    nginx = {
      enable = bool;
    };
    ollama = {
      enable = bool;
    };
    openlist = {
      enable = bool;
    };
    openssh = {
      enable = bool;
    };
    pipewire = {
      enable = bool;
    };
    rustdesk-server = {
      enable = bool;
      relayHosts = listOfStr;
    };
    searxng = {
      enable = bool;
      firewall = attrs;
    };
    sing-box = {
      enable = bool;
    };
    snapper = {
      enable = bool;
    };
    sops-nix = {
      enable = bool;
    };
    udiskie = {
      enable = bool;
    };
    zerotierone = {
      enable = bool;
      joinNetworks = listOfStr;
    };
  };
  shell = {
    bash = {
      enable = bool;
    };
    fish = {
      enable = bool;
    };
  };
  terminal = {
    foot = {
      enable = bool;
    };
    kitty = {
      enable = bool;
    };
  };
  tool = {
    clash-verge = {
      enable = bool;
    };
    fcitx5 = {
      enable = bool;
    };
    lutris = {
      enable = bool;
    };
    mission-center = {
      enable = bool;
    };
    onlyoffice = {
      enable = bool;
    };
    pince = {
      enable = bool;
    };
  };
}
