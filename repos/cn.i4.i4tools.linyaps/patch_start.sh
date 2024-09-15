#!/bin/bash

sed -i -e "s#LD_LIBRARY_PATH=#LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:#" "$PREFIX/i4tools/i4toolslinux.sh"