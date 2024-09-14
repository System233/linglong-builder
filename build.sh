#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

export PATH=$PATH:$(pwd)/node_modules/.bin

if [ ! -e "$DIR" ]; then
    yarn ll-helper convert "$APP_ID" --name "$APP_NAME" --with-linyaps --from ./template --quiet
    cp -v ./.gitignore "${NEW_APP_ID}"
fi
cd "${NEW_APP_ID}"
echo CWD=$(pwd)
ll-helper patch ld icon

ls -l
ll-helper resolve
