# 🧩 选项集管理

[⬅️ 返回主文档](../../README.md)

---

## 📑 目录

- [1. 什么是选项集](#1-什么是选项集)
- [2. 预定义选项集说明](#2-预定义选项集说明)
- [3. 如何使用选项集](#3-如何使用选项集)
- [4. 自定义选项集开发指南](#4-自定义选项集开发指南)

---

## 1. 什么是选项集

**选项集（OptSet）** 是预配置的 Nix 选项集合，用于通过组合式高级抽象减少样板代码。

> **💡 核心设计理念**：将常用的、可复用的配置抽取为独立模块，
> 用户和主机只需引用即可生效，无需重复编写相同配置。
> 选项集之间可以自由组合，实现"乐高式"的配置管理。

**核心优势**：

| 优势         | 说明                             |
| ------------ | -------------------------------- |
| 减少样板代码 | 常用配置一次定义，多处复用       |
| 提高复用性   | 同一选项集可被多个用户/主机引用  |
| 易于维护     | 修改一处即全局生效，避免配置漂移 |
| 组合式设计   | 多个选项集可自由叠加，按需组合   |

---

## 2. 预定义选项集说明

系统内置以下预定义选项集，位于 `outputs/optSets/` 目录下：

| 文件                             | 说明              |
| -------------------------------- | ----------------- |
| [baseEnv.nix](./baseEnv.nix)     | 基础环境选项集    |
| [devEnv.nix](./devEnv.nix)       | 开发工具选项集    |
| [fishShell.nix](./fishShell.nix) | Fish Shell 选项集 |

建议按以下方式查阅具体内容：

```bash
# 查看各选项集的定义
cat outputs/optSets/baseEnv.nix
cat outputs/optSets/devEnv.nix
cat outputs/optSets/fishShell.nix
```

> **💡 提示**：预定义选项集的内容可能随项目演进而调整，
> 请以源文件为准。

---

## 3. 如何使用选项集

在 `opts.nix` 中导入并引用选项集：

```nix
let
  optSets = import ../../optSets { inherit inputs; };
  predefinedOptSetsList = [
    optSets.baseEnv         # 引用基础环境选项集
    optSets.devEnv          # 引用开发工具选项集
    optSets.fishShell       # 引用 Fish Shell 选项集
  ];
  customOptSets = { ... };  # 自定义配置
  opts = functions.mergeOptSetsList customOptSets predefinedOptSetsList;
in
opts
```

**合并机制**：

- `mergeOptSetsList` 按列表顺序从右向左合并（后者覆盖前者）
- 自定义配置 `customOptSets` 拥有最高优先级，可覆盖任何预定义选项集的值
- 支持深度合并，不会丢失未被覆盖的字段

---

## 4. 自定义选项集开发指南

创建新的选项集仅需 **2 步**，无需修改任何其他文件：

```bash
# 在 outputs/optSets/ 下创建新的 .nix 文件
touch outputs/optSets/myOptSet.nix

# 编写选项集内容
nano outputs/optSets/myOptSet.nix
```

> **💡 自动发现机制**：`default.nix` 通过 `importDirFiles` 自动扫描目录下所有 `.nix` 文件，
> 新建的选项集文件会自动被识别和导出，无需手动注册！

**无需做的操作** ❌：

- ~~修改 `default.nix`~~ — 自动扫描，无需手动注册
- ~~修改 Flake 入口~~ — 无需在顶层声明新选项集
- ~~创建其他配置文件~~ — 只需关注你的 `.nix` 文件本身

---

<div align="center">

### 开始构建你的选项集吧！🚀

如有问题，欢迎查阅 [常见问题](../../docs/faq.md) 或提交 Issue

</div>
