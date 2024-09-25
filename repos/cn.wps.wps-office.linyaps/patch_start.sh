#!/bin/bash

sed -i -E -e "s#/opt/apps/cn.wps.wps-office/files#$PREFIX#g" $PREFIX/bin/*
cp -v /project/fonts/* $PREFIX/share/fonts/wps-office/
chmod -v 644 $PREFIX/share/fonts/wps-office/*
