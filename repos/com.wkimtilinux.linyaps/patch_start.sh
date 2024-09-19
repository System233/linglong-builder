#!/bin/bash

sed -i -e "s#/opt/apps/com.wkimtilinux/files/logo.png#$PREFIX/logo.png#g" $PREFIX/share/applications/*.desktop
