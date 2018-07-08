#!/bin/bash

usermod  -u $(stat -c '%u' /app) build
groupmod -g $(stat -c '%g' /app) build

if [ ! -f /app/workspace.yml ]; then
    echo "workspace.yml not found."
    exit 1
fi

PACK_SOURCE=$(cat /app/workspace.yml | shyaml get-value meta.source)
PACK_PATH=/app/.workspace

# download pack
echo "Downloading workspace pack..."
CMD="git clone --depth=1 --branch=master "${PACK_SOURCE}" "${PACK_PATH}" && rm -rf "${PACK_PATH}/.git""
echo $CMD
su -c "$CMD" build

# render templates
su -c pack-render build
