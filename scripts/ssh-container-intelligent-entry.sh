#!/usr/bin/env bash
CONTAINER="$1"

if [ -z "$CONTAINER" ]; then
    # 未设置 CONTAINER 环境变量直接退出
    exit 1
fi

if [ -z "$SSH_ORIGINAL_COMMAND" ]; then
    # 无命令: 交互式登录直接进入容器 bash
    exec podman exec -it "$CONTAINER" bash
else
    # 有命令: 在容器内执行该命令
    exec podman exec -i "$CONTAINER" bash -c "$SSH_ORIGINAL_COMMAND"
fi
