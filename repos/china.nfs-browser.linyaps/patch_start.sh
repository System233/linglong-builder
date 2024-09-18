#!/bin/bash

ln -svf $PREFIX/opt/nfs-browser/* $PREFIX/bin
while read line; do
    SIZE=$(echo $line | grep -oP "_\K\d+")
    DIR="$PREFIX/share/icons/hicolor/${SIZE}x${SIZE}/apps"
    mkdir -pv "$DIR"
    cp -vf "$line" "$DIR/china.nfs-browser.linyaps_nfs-browser.png"
done <<<$(ls $PREFIX/opt/nfs-browser/icons/product_logo_*.png)
