#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

CWD=$(pwd)
export PATH=$PATH:${CWD}/node_modules/.bin

cd "${REPO_ROOT}"
if [ ! -e "$DIR" ]; then
    yarn ll-helper convert "$APP_ID" --name "$APP_NAME" --with-linyaps --from "${CWD}/com.uniontech.foundation" --quiet --cache-dir "${CACHE_DIR}"
    cp -v ./.gitignore "${APP_DIR}"
fi
cd "${APP_DIR}"
echo CWD=$(pwd)

ll-helper patch ld icon

echo [搜索依赖]
ll-helper resolve --cache-dir ${CACHE_DIR}

echo [正式构建]
ll-builder build
echo [导出Layer]
ll-builder export -l
