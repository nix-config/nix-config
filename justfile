# 查看输出
show:
    nix flake show .

# 构建并切换 nixos
switch-nixos *args:
    nh os switch . --ask {{args}}

# 构建并切换 home
switch-home *args:
    nh home switch . --ask {{args}}

# 更新
update *args: 
    -cd ./repositories/knightfemale/nur-packages/ && just update {{args}}
    nix flake update {{args}}

# 清理
clean *args:
    nh clean all --no-gcroots --ask {{args}}

# 格式化
format:
    -cd ./repositories/knightfemale/nur-packages/ && just format
    treefmt .

# 查看被依赖链
depend hostname pkgname:
    #!/usr/bin/env bash
    set -euo pipefail
    SYS_DRV=$(nix eval --raw .#nixosConfigurations.{{hostname}}.config.system.build.toplevel.drvPath)
    while read -r PKG_DRV; do
        nix why-depends "$SYS_DRV" "$PKG_DRV"
        echo
    done < <(nix-store -qR "$SYS_DRV" | grep {{pkgname}})
