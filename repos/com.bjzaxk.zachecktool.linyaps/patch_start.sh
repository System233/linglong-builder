#!/bin/bash
rm -rvf $PREFIX/aarch64 $PREFIX/mips64
echo "exec $PREFIX/x86_64/bin/runchk.sh \$@" | tee -a "$PREFIX/bin/runchk.sh"
chmod +x "$PREFIX/bin/runchk.sh"