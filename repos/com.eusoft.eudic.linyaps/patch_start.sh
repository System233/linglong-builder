#!/bin/bash
sed -i "s#QT_QPA_PLATFORM=''##g" $PREFIX/share/applications/*.desktop
