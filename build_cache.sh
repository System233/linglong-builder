#!/bin/bash

set -e

echo [准备缓存]

DIR=$(dirname $0)
function build(){
    cd "$DIR/$1"
    apt-cli resolve "example" -c "${CACHE_DIR}" -f "./sources.list" 
    apt-cli find "example" -c "${CACHE_DIR}" -f "./sources.list" 
    ll-builder build
    ll-builder run
}

build com.uniontech.foundation &
build org.deepin.foundation &

wait

echo 缓存已就绪
