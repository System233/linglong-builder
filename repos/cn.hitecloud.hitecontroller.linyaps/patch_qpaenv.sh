#!/bin/bash

echo 'export QT_QPA_PLATFORM=xcb' | tee -a $LINGLONG_COMMAND
sed -i -e "s#cn.hitecloud.hitecontroller#cn.hitecloud.hitecontroller.linyaps#g" "$PREFIX/Release/Linux/Own/HiteReboot.sh"