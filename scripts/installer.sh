#!/usr/bin/env bash

# =============================================================================
# 提供三种操作模式的统一入口:
#   [1] LiveCD 安装 — 从 NixOS LiveCD 环境初始化全新系统
#   [2] 应用主机配置 — 将本仓库的 nixosConfigurations 部署到当前机器
#   [3] 应用用户配置 — 将本仓库的 homeConfigurations 部署到当前用户
# =============================================================================

set -e

# -----------------------------------------------------------------------------
# 全局路径变量
# -----------------------------------------------------------------------------
# 脚本所在目录 (scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 仓库根目录
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# Nix 模块目录
MODULES_DIR="$SCRIPT_DIR/modules"
# 函数目录
FUNCTIONS_DIR="$SCRIPT_DIR/functions"

# =============================================================================
# 通用工具函数
# =============================================================================

# -----------------------------------------------------------------------------
# 打印错误信息并退出
# -----------------------------------------------------------------------------
die() {
    echo "Error: $*" >&2
    exit 1
}

# -----------------------------------------------------------------------------
# 确认操作 (默认 y/N)
# -----------------------------------------------------------------------------
confirm() {
    local prompt="${1:-Continue?}"
    local default="${2:-N}"
    local yn

    if [ "$default" = "N" ]; then
        read -r -p "$prompt [y/N]: " yn
        case "$yn" in
            [Yy]*) return 0 ;;
            *)     return 1 ;;
        esac
    else
        read -r -p "$prompt [Y/n]: " yn
        case "$yn" in
            [Nn]*) return 1 ;;
            *)     return 0 ;;
        esac
    fi
}

# =============================================================================
# 加载函数模块
# =============================================================================
source "$FUNCTIONS_DIR/disk.sh"
source "$FUNCTIONS_DIR/host.sh"
source "$FUNCTIONS_DIR/user.sh"

# =============================================================================
# 模式 1 — LiveCD 环境全新安装 NixOS
# =============================================================================
livecd_install() {
    echo ""
    echo "=========================================="
    echo "  Mode: LiveCD Install"
    echo "=========================================="
    echo ""

    # 1. 选择目标磁盘
    echo "--- Select Target Disk ---"
    select_disk

    # 2. 警告确认
    echo ""
    echo "WARNING: All data on $DISK will be PERMANENTLY DESTROYED!"
    confirm "Proceed with installation?" || die "Installation cancelled by user"

    # 3. 卸载已挂载分区
    unmount_disk "$DISK"

    # 4. 分区/格式化/挂载 (通过 Disko)
    echo ""
    echo "--- Partitioning Disk ---"
    sudo nix run 'github:nix-community/disko/v1.13.0' \
        --extra-experimental-features "nix-command flakes" \
        --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store https://mirrors.ustc.edu.cn/nix-channels/store https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" \
        -- \
        --argstr disk "$DISK" \
        --yes-wipe-all-disks \
        --mode destroy,format,mount "$MODULES_DIR/disk-config.nix"

    # 5. 生成基础硬件配置
    echo ""
    echo "--- Generating Hardware Configuration ---"
    sudo nixos-generate-config --root /mnt

    # 6. 复制额外配置文件并注入引用
    echo ""
    echo "--- Injecting Extra Configuration ---"
    sudo cp "$MODULES_DIR/extra-configuration.nix" /mnt/etc/nixos/extra-configuration.nix
    sudo sed -i 's|./hardware-configuration.nix|./hardware-configuration.nix\n      ./extra-configuration.nix|' /mnt/etc/nixos/configuration.nix

    # 7. 安装系统
    echo ""
    echo "--- Installing NixOS ---"
    sudo nixos-install --root /mnt \
        --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store https://mirrors.ustc.edu.cn/nix-channels/store https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

    echo ""
    echo "=========================================="
    echo "  LiveCD installation complete!"
    echo "  Reboot and run this script again"
    echo "  with Mode 2 to apply a host configuration."
    echo "=========================================="
}

# =============================================================================
# 模式 2 — 应用 NixOS 主机配置到当前系统
# =============================================================================
apply_host_config() {
    echo ""
    echo "=========================================="
    echo "  Mode: Apply Host Configuration"
    echo "=========================================="
    echo ""

    # 1. 选择目标主机
    echo "--- Select Target Host ---"
    select_host

    # 2. 生成当前机器的硬件配置
    echo ""
    echo "--- Generating Hardware Configuration ---"
    sudo nixos-generate-config

    # 3. 复制硬件配置到主机目录
    echo "--- Copying Hardware Configuration ---"
    sudo cp /etc/nixos/hardware-configuration.nix "$HOST_PATH/"

    # 4. 暂存变更并重建系统
    echo ""
    echo "--- Rebuilding System ---"
    cd "$REPO_ROOT"
    git add --all
    nix-shell -p nh --run "nh os switch .#$HOST_NAME --ask --max-jobs 1"

    echo ""
    echo "=========================================="
    echo "  Host configuration applied: $HOST_NAME"
    echo "=========================================="
}

# =============================================================================
# 模式 3 — 应用 Home Manager 用户配置
# =============================================================================
apply_user_config() {
    echo ""
    echo "=========================================="
    echo "  Mode: Apply User Configuration"
    echo "=========================================="
    echo ""

    # 1. 选择目标用户
    echo "--- Select Target User ---"
    select_user

    # 2. 暂存变更并应用 home 配置
    echo ""
    echo "--- Applying Home Manager Configuration ---"
    cd "$REPO_ROOT"
    git add --all
    nix-shell -p nh --run "nh home switch . -c $USER_NAME --ask --max-jobs 1"

    echo ""
    echo "=========================================="
    echo "  User configuration applied: $USER_NAME"
    echo "=========================================="
}

# =============================================================================
# 主菜单 — 选择操作模式
# =============================================================================
main_menu() {
    echo ""
    echo "=========================================="
    echo "  Nix Config Installer"
    echo "=========================================="
    echo ""
    echo "Select installation mode:"
    echo "  [1] LiveCD Install"
    echo "      Initialize a new NixOS system from LiveCD environment"
    echo "      (disk partitioning, base system installation)"
    echo ""
    echo "  [2] Apply Host Configuration"
    echo "      Deploy a nixosConfiguration from this flake to the current machine"
    echo "      (requires NixOS already installed)"
    echo ""
    echo "  [3] Apply User Configuration"
    echo "      Deploy a homeConfiguration from this flake to the current user"
    echo "      (requires Home Manager and nix flakes enabled)"
    echo ""

    while true; do
        read -r -p "Enter selection [1-3]: " mode
        case "$mode" in
            1) livecd_install; break ;;
            2) apply_host_config; break ;;
            3) apply_user_config; break ;;
            *) echo "Invalid selection, please enter 1, 2, or 3" ;;
        esac
    done
}

# =============================================================================
# 脚本入口
# =============================================================================
main_menu
