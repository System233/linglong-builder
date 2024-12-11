#!/bin/bash

echo Applying Patch: libm
LIBM=`find $PREFIX -name "libm.so.6"`
if [ -e "$LIBM" ];then
    mv -v "$LIBM" "$LIBM.bak"
fi