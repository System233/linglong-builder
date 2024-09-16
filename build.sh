#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
set -e
CWD=$(pwd)
echo CMD=${CMD}
echo CWD=${CWD}
echo REPO_ROOT=${REPO_ROOT}
echo APP_DIR=${APP_DIR}
echo APP_ID=${APP_ID}
echo APP_NAME=${APP_NAME}
export PATH=$PATH:${CWD}/node_modules/.bin

cd "${REPO_ROOT}"

if [ -e "$APP_DIR" ]; then
    cd "${APP_DIR}"
    BASE_NAME=$(grep -q "appstorev23" "linglong.yaml" && echo org.deepin.foundation || echo "com.uniontech.foundation")
    BASE="${CWD}/${BASE_NAME}"
else
    BASE_NAME=$(apt-cli resolve "${APP_ID}" -c "${CACHE_DIR}" -f "${CWD}/com.uniontech.foundation/sources.list" | grep -q "missing" && echo org.deepin.foundation || echo "com.uniontech.foundation")
    BASE="${CWD}/${BASE_NAME}"
    ll-helper convert "$APP_ID" --name "$APP_NAME" --with-linyaps --from "${BASE}" --quiet --cache-dir "${CACHE_DIR}"
    cd "${APP_DIR}"
    ll-helper patch ld icon --from "${BASE}"
fi

if [ "$CMD" == "resolve" ]; then
    ll-helper resolve --cache-dir ${CACHE_DIR} --from "${BASE}"
fi

if [ "$CMD" == "build" ]; then
    ll-builder build
    ll-builder export -l
fi
