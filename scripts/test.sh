#!/bin/bash
APP_ID=$(basename $(readlink -f .))

echo "正在测试 $APP_ID"
ll-builder export -l
ll-cli uninstall $APP_ID
ll-cli install $APP_ID*_binary.layer

echo "测试快捷方式 $APP_ID"
exec check_desktop.sh

rm *.layer
