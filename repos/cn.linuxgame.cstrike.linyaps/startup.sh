#!/bin/bash
PREFIX=/opt/apps/cn.linuxgame.cstrike.linyaps/files
export LD_LIBRARY_PATH=$PREFIX/lib/i386-linux-gnu:$PREFIX/bin/cstrike:$PREFIX/bin/cstrike/steam-runtime/i386/usr/lib/i386-linux-gnu/:$PREFIX/bin/cstrike/steam-runtime/i386/lib/i386-linux-gnu/
export LIBGL_DRIVERS_PATH=$PREFIX/lib/i386-linux-gnu/dri/

SRC=$PREFIX/bin/cstrike
ROOT=$HOME/.config/cstrike
mkdir -p $ROOT 2>/dev/null

ln -sf $SRC/* $ROOT

rm $ROOT/cstrike
mkdir $ROOT/cstrike
cd $SRC/cstrike
while read line; do
    mkdir -p "$ROOT/cstrike/$line"
done <<<$(find . -type d -print)

while read line; do
    ln -sf "$SRC/$line" "$ROOT/cstrike/$line"
done <<<$(find . -print)

cd $ROOT
$PREFIX/lib/ld-linux.so.2 ./hl_linux -game cstrike -dll addons/metamod/dlls/metamod.so $@
