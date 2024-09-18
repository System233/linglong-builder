#!/bin/bash

echo "export QT_QPA_PLATFORM=xcb" | tee -a $LINGLONG_COMMAND
echo "export QT_QPA_PLATFORM_PLUGIN_PATH=$PREFIX/plugins/platforms"  | tee -a $LINGLONG_COMMAND
