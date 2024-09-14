#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

SRC=$1
if [ ! -e "$SRC" ]; then
    exit 1
fi
NAME=$(basename "$SRC")
while read line; do
    cp -v "$SRC" "$line"
done <<<$(find repos -name "$NAME")
