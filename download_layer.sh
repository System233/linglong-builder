#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

TAG_NAME=$1
if [ -z "$TAG_NAME" ]; then
    TAG_NAME=$(date '+%Y%m%d')
fi
PARALLEL=4
TRIES=3
curl --silent "https://api.github.com/repos/System233/linglong-builder/releases/tags/${TAG_NAME}" | jq -r '.assets.[].browser_download_url ' | xargs -P${PARALLEL} -rn1 wget --tries=${TRIES} -c
