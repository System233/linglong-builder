#!/bin/bash
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

while read line; do
    echo $line
    cat $line | sort -u >$line
done <<<$(find repos -name "sources.list")
