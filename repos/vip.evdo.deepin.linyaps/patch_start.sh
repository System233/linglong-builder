#!/bin/bash

sed -i -e "s#/opt/apps/vip.evdo.deepin/entries/icons/hicolor/vip.evdo.deepin#$PREFIX/share/icons/hicolor/vip.evdo.deepin.png#" $PREFIX/share/applications/*.desktop
