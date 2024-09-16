#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

while read line; do
    APPID=${line}.linyaps
    DIR=repos/$APPID
    YAML=$DIR/linglong.yaml
    if grep -q "com.uniontech.foundation/20.0.1" "${YAML}" && grep -q "beige" "${YAML}"; then
        ./build_target.sh "${APPID}"
    fi
done <resolve.list
