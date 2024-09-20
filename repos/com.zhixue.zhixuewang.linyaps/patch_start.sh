#!/bin/bash
rm -rf  $PREFIX/share/browser/ $PREFIX/lib/*

sed -i -e 's#--app=##g' $PREFIX/share/applications/*.desktop
