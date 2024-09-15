#!/bin/bash

echo 'export QT_QPA_PLATFORM=xcb' | tee -a $LINGLONG_COMMAND
sed -i -e 's#cn.com.xcsa.uos#cn.com.xcsa.uos.linyaps#g' $PREFIX/envCheck.sh