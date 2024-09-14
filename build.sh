#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

CWD=$(pwd)
echo CWD=${CWD}
echo REPO_ROOT=${REPO_ROOT}
echo APP_DIR=${APP_DIR}
echo APP_ID=${APP_ID}
echo APP_NAME=${APP_NAME}
BASE="${CWD}/com.uniontech.foundation"
export PATH=$PATH:${CWD}/node_modules/.bin

cd "${REPO_ROOT}"

if [ ! -e "$DIR" ]; then
    ll-helper convert "$APP_ID" --name "$APP_NAME" --with-linyaps --from "${BASE}" --quiet --cache-dir "${CACHE_DIR}"
    cp -v ${CWD}/.gitignore "${APP_DIR}"
fi
cd "${APP_DIR}"

ll-helper patch ld icon

echo [搜索依赖]
ll-helper resolve --cache-dir ${CACHE_DIR}

echo [正式构建]
ll-builder build
echo [导出Layer]
ll-builder export -l
