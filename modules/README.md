# ⚙️ 模块管理

[⬅️ 返回主文档](../README.md)

---

## 📑 目录

- [1. 目录结构概览](#1-目录结构概览)
- [2. 模块分类说明](#2-模块分类说明)
- [3. 如何开发新模块](#3-如何开发新模块)

---

## 1. 目录结构概览

| 层级        | 作用域                  |
| ----------- | ----------------------- |
| nixos 模块  | NixOS 系统级配置        |
| home 模块   | Home Manager 用户级配置 |
| darwin 模块 | macOS 配置              |

所有模块通过编排层的 `recursive.collectFilesToList` 自动发现，零注册。

---

## 2. 模块分类说明

| 分类         | 路径         |
| ------------ | ------------ |
| 命令行工具   | `cli/`       |
| 实用工具     | `tool/`      |
| 本地化和语言 | `i18n/`      |
| 媒体应用     | `media/`     |
| 编辑器       | `editor/`    |
| 命令解释器   | `shell/`     |
| 桌面环境     | `desktop/`   |
| 终端模拟器   | `terminal/`  |
| 系统服务     | `service/`   |
| 网络应用     | `internet/`  |
| 硬件配置     | `hardware/`  |
| 容器管理     | `container/` |

---

## 3. 如何开发新模块

创建新模块仅需 **2 步**，无需修改任何其他文件：

```bash
# 在对应分类目录下创建 .nix 文件
touch modules/nixos/<category>/my-module.nix  # nixos 模块示例
touch modules/home/<category>/my-module.nix   # home 模块示例
touch modules/darwin/<category>/my-module.nix # darwin 模块示例

# 编写模块内容
nano modules/nixos/<category>/my-module.nix
nano modules/home/<category>/my-module.nix
nano modules/darwin/<category>/my-module.nix
```

**标准模板**：

```nix
{
  lib,
  opts,
  ...
}:
let
  cfg = opts.<分类>.<模块名> or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    # 在此编写配置
  };
}
```

> **💡 自动发现机制**：通过 `recursive.collectFilesToList` 递归扫描目录，新建并被 git 跟踪的 `.nix` 模块文件会被自动识别并导入，无需手动注册！

**无需做的操作** ❌：

- ~~修改 `default.nix`~~ — 自动扫描子目录，无需手动注册
- ~~修改 Flake 入口~~ — 无需在顶层声明新模块
- ~~修改其他任何文件~~ — 只需关注你的 `.nix` 模块文件本身

---

<div align="center">

### 开始构建你的模块吧！🚀

如有问题，欢迎查阅 [常见问题](../docs/faq.md) 或提交 Issue

</div>
