#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

if [ ! -e "$DIR" ]; then
    yarn ll-helper convert "$APP_ID" --name "$APP_NAME" --with-linyaps --from ./template
    cp -v ./.gitignore "${NEW_APP_ID}"
fi
cd "${NEW_APP_ID}"
yarn ll-helper patch ld icon
yarn ll-helper resolve
