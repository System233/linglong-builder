#!/bin/bash

set -e

export PATH=$PATH:$(pwd)/node_modules/.bin

echo [准备缓存]

DIR=$(dirname $0)
function build() {
    cd "$DIR/$1"
    # apt-cli resolve "never-apt-cli" -c "${CACHE_DIR}" -f "./sources.list"
    # apt-cli find "never-apt-cli" -c "${CACHE_DIR}" -f "./sources.list"
    ll-builder build
    ll-builder run
}

build com.uniontech.foundation &
pid1=$!
build org.deepin.foundation &
pid2=$!
build org.deepin.foundation.v20 &
pid3=$!
build org.deepin.base &
pid4=$!

wait $pid1
wait $pid2
wait $pid3
wait $pid4

echo 缓存已就绪
