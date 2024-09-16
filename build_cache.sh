#!/bin/bash

set -e

export PATH=$PATH:$(pwd)/node_modules/.bin

echo [准备缓存]

DIR=$(dirname $0)
function build() {
    cd "$DIR/$1"
    apt-cli resolve "never-apt-cli" -c "${CACHE_DIR}" -f "./sources.list" 2>&1 | grep -viq "Error" || (echo ${1}包索引缓存失败 && false)
    apt-cli find "never-apt-cli" -c "${CACHE_DIR}" -f "./sources.list" 2>&1 | grep -viq "Error" || (echo ${1}包内容缓存失败 && false)
    ll-builder build
    ll-builder run
}

build com.uniontech.foundation &
pid1=$!
build org.deepin.foundation &
pid2=$!

wait $pid1 && wait $pid2

echo 缓存已就绪
