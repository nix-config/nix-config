# 查看输出
show:
    nix flake show .

# 构建系统
os *args:
    nh os switch . --ask {{args}}

# 构建用户
home *args:
    nh home switch . --ask {{args}}

# 更新锁文件
update *args: 
    -cd repositories/knightfemale/nur-packages && nix flake update {{args}}
    nix flake update {{args}}

# 清理 (不清理 flake+direnv 环境)
clean *args:
    nh clean all --no-gcroots --ask {{args}}

# 格式化 nix 文件
format:
    treefmt .

# 依赖分析
depend hostname pkgname:
    #!/usr/bin/env bash
    set -euo pipefail
    SYS_DRV=$(nix eval --raw .#nixosConfigurations.{{hostname}}.config.system.build.toplevel.drvPath)
    while read -r PKG_DRV; do
        nix why-depends "$SYS_DRV" "$PKG_DRV"
        echo
    done < <(nix-store -qR "$SYS_DRV" | grep {{pkgname}})
