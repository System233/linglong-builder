#!/bin/bash

set -e

export PATH=$PATH:$(pwd)/node_modules/.bin

echo [准备缓存]

DIR=$(dirname $0)
function build() {
    cd "$DIR/$1"
    apt-cli resolve "example" -c "${CACHE_DIR}" -f "./sources.list"
    apt-cli find "example" -c "${CACHE_DIR}" -f "./sources.list"
    ll-builder build
    ll-builder run
}

build com.uniontech.foundation &
pid1=$!
build org.deepin.foundation &
pid2=$!

wait $pid1 && wait $pid2

echo 缓存已就绪
