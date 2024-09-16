#!/bin/bash

echo [准备缓存]

DIR=$(dirname $0)
function build(){
    cd "$DIR/$1"
    ll-builder build
}

build com.uniontech.foundation &
build org.deepin.foundation &

wait

echo 缓存已就绪
