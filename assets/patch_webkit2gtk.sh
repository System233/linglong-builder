#!/bin/bash
# generated by ll-helper
echo Patch webkit2gtk
perl -pi -e 's#/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0#/usx/lib/x86_64-linux-gnu/webkit2gtk-4.0#g' $PREFIX/lib/x86_64-linux-gnu/libwebkit2gtk-4.0.so*
echo "ls -sf '$PREFIX' /usx" | tee -a $LINGLONG_COMMAND