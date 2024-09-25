#!/bin/bash

XCB_PATH=$(find $PREFIX -path "*/platforms/*xcb*" -print -quit)
PLATFORM_DIR=$(dirname $XCB_PATH)
PLUGIN_DIR=$(readlink -f "$PLATFORM_DIR")

if [ -e "$XCB_PATH" ]; then
    echo "export QT_QPA_PLATFORM=xcb" | tee -a $LINGLONG_COMMAND
    echo "export QT_QPA_PLATFORM_PLUGIN_PATH=$PLATFORM_DIR" | tee -a $LINGLONG_COMMAND
    echo "export QT_PLUGIN_PATH=$PLUGIN_DIR" | tee -a $LINGLONG_COMMAND
fi
