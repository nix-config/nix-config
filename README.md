<div align="center">

# ✨ 适用于任何场景的 Nix 配置框架实现

细粒度 · 高隔离 · 松耦合 · 多模式

</div>

---

## 📑 文档索引

| 文档                                      | 内容               | 作用                               |
| ----------------------------------------- | ------------------ | ---------------------------------- |
| 📜 [脚本指南](./scripts/README.md)        | 实用脚本的使用介绍 | 一些包含安装等功能的脚本           |
| 🖥️ [主机管理](./outputs/nixos/README.md)  | 增删改查主机配置   | 配置主机输出                       |
| 👤 [用户管理](./outputs/home/README.md)   | 增删改查用户配置   | 配置用户输出                       |
| 🧩 [选项集管理](./vars/optSets/README.md) | 增删改查选项集     | 方便复用与减少样板代码的组合式选项 |
| ⚙️ [模块管理](./modules/README.md)        | 增删改查 nix 模块  | 决定系统及软件行为的配置           |
| 🏗️ [架构概览](./docs/architecture.md)     | 设计理念           | 了解由设计理念衍生出的整体架构     |
| ❓ [常见问题](./docs/faq.md)              | 故障排查           | 常见错误速查                       |

---

## 📂 目录结构

```bash
.
├── docs/                                       # 项目文档
├── modules/                                    # 模块
│   ├── darwin/                                 # darwin 模块
│   │   └── <category>/                         # 模块分类
│   ├── home/                                   # home 模块
│   │   └── <category>/                         # 模块分类
│   └── nixos/                                  # nixos 模块
│       └── <category>/                         # 模块分类
├── outputs/                                    # Flake 输出
│   ├── home/                                   # 用户
│   │   └── <user>/                             # 具体用户
│   │       └── opts.nix                        # 用户选项定义
│   └── nixos/                                  # 主机
│       └── <host>/                             # 具体主机
│           ├── hardware-configuration.nix      # 主机硬件配置
│           └── opts.nix                        # 主机选项定义
├── repositories/                               # 开发仓库
├── scripts/                                    # 工具脚本
├── secrets/                                    # 私密文件
├── vars/                                       # 公共变量
├── .sops.yaml                                  # sops 配置
├── flake.lock                                  # Flake 版本锁
├── flake.nix                                   # Flake 输入
└── justfile                                    # 快捷命令
```

---

## 📦 输出总览

### [NixOS 主机](./outputs/nixos/README.md)

| Hostname                                        | Board                                                                                                         | CPU                                                                                                                                                                       | RAM  | GPU                                                                                                                                                                          | Disk                                                                                                                                                                                 | OS  | Role     | State |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- | -------- | ----- |
| [default](./outputs/nixos/default/opts.nix)     | -                                                                                                             | -                                                                                                                                                                         | -    | -                                                                                                                                                                            | -                                                                                                                                                                                    | ❄️  | 📋       | -     |
| [fl8850ua](./outputs/nixos/fl8850ua/opts.nix)   | [X515UA](https://www.asus.com/supportonly/x515ua/helpdesk/)                                                   | [AMD Ryzen™ 7 5700U](https://www.amd.com/en/support/downloads/drivers.html/processors/ryzen/ryzen-5000-series/amd-ryzen-7-5700u.html)                                     | 16GB | AMD Radeon RX Vega 8                                                                                                                                                         | 1TB SATA SSD                                                                                                                                                                         | ❄️  | 💻 ⌨️ 🎮 | ✅    |
| [alc](./outputs/nixos/alc/opts.nix)             | -                                                                                                             | Intel® Xeon® Platinum (2) @ 2.50 GHz                                                                                                                                      | 2GB  | Cirrus Logic GD 5446                                                                                                                                                         | 40GB VD                                                                                                                                                                              | ❄️  | ☁️       | ✅    |
| [wsl-c8i](./outputs/nixos/wsl-c8i/opts.nix)     | [ROG Crosshair VIII Impact](https://rog.asus.com/motherboards/rog-crosshair/rog-crosshair-viii-impact-model/) | [AMD Ryzen™ 5 5600](https://www.amd.com/en/support/downloads/drivers.html/processors/ryzen/ryzen-5000-series/amd-ryzen-5-5600.html)                                       | 64GB | NVIDIA RTX 4070 Ti SUPER                                                                                                                                                     | [Ultrastar DC SN640 - 7.68TB](https://www.sandisk.com/products/ssd/internal-ssd/ultrastar-dc-sn640-nvme-ssd?sku=0TS1930)                                                             | ❄️  | 🖥️ ⌨️ 🤖 | ✅    |
| [wsl-work](./outputs/nixos/wsl-work/opts.nix)   | -                                                                                                             | [Intel® Core™ i5-10500](https://www.intel.com/content/www/us/en/products/sku/199277/intel-core-i510500-processor-12m-cache-up-to-4-50-ghz/specifications.html)            | 16GB | [Intel® UHD Graphics 630](https://www.intel.com/content/www/us/en/support/products/126790/graphics/processor-graphics/intel-uhd-graphics-family/intel-uhd-graphics-630.html) | 256GB NVMe SSD                                                                                                                                                                       | ❄️  | 🖥️ ⌨️    | ✅    |
| [x99-6plus](./outputs/nixos/x99-6plus/opts.nix) | -                                                                                                             | [Intel® Xeon® Processor E5-2680 v4](https://www.intel.com/content/www/us/en/products/sku/91754/intel-xeon-processor-e52680-v4-35m-cache-2-40-ghz/specifications.html) × 2 | 32GB | NVIDIA Tesla T10 16 GB × 2                                                                                                                                                   | [118GB Optane](https://www.intel.com/content/www/us/en/products/sku/211867/intel-optane-ssd-p1600x-series-118gb-m-2-80mm-pcie-3-0-x4-3d-xpoint/specifications.html) + 500GB SATA HDD | ❄️  | 🗄️ 🤖    | ✅    |

### [Home Manager 用户](./outputs/home/README.md)

| Hostname                                   | Board                                                                                                                        | CPU                                                                                                                                                                 | RAM   | GPU                           | Disk         | OS  | Role | State |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- | ----------------------------- | ------------ | --- | ---- | ----- |
| [default](./outputs/home/default/opts.nix) | -                                                                                                                            | -                                                                                                                                                                   | -     | -                             | -            |     | 📋   | -     |
| [mint](./outputs/home/mint/opts.nix)       | [TUF GAMING Z790-PLUS WIFI](https://www.asus.com/motherboards-components/motherboards/tuf-gaming/tuf-gaming-z790-plus-wifi/) | [Intel® Core™ i9-14900KF](https://www.intel.com/content/www/us/en/products/sku/236787/intel-core-i9-processor-14900kf-36m-cache-up-to-6-00-ghz/specifications.html) | 192GB | NVIDIA GeForce RTX 5090 × 2   | 2TB NVMe SSD | 🌿  | 🖥️   | ❌    |
| [ubuntu](./outputs/home/ubuntu/opts.nix)   | [PRIME Z790-P](https://www.asus.com/motherboards-components/motherboards/prime/prime-z790-p/)                                | [Intel® Core™ i9-14900K](https://www.intel.com/content/www/us/en/products/sku/236773/intel-core-i9-processor-14900k-36m-cache-up-to-6-00-ghz/specifications.html)   | 96GB  | NVIDIA GeForce RTX 4090 D × 2 | 2TB NVMe SSD | 🟠  | 🖥️   | ❌    |

> 💡 图标说明：
> ❄️ NixOS &nbsp; 🌿 Linux Mint &nbsp; 🟠 Ubuntu
> 📋 模板 &nbsp; 💻 笔记本 &nbsp; 🖥️ 台式 &nbsp; 🗄️ 服务器 &nbsp; ☁️ 云服务器
> ⌨️ 开发 &nbsp; 🎮 游戏 &nbsp; 🤖 AI &nbsp; 🎨 图形
> ✅ 运行中 &nbsp; ❌ 停用 &nbsp;

---

## 🔗 相关资源

- [NixOS 官方文档](https://nixos.org/manual/nixos/stable/)
- [Disko 文档](https://github.com/nix-community/disko)
- [Home Manager 文档](https://nix-community.github.io/home-manager/)
- [Nix Flakes 文档](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake)

---

<div align="center">

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/nix-config/nix-config)

</div>
