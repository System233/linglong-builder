#!/bin/bash

echo "ln -sf $PREFIX/lib /x32" |tee -a "$LINGLONG_COMMAND"
echo "ln -sf $PREFIX $PREFIX/usr" |tee -a "$LINGLONG_COMMAND"
echo "export LD_LIBRARY_PATH=$PREFIX/lib/i386-linux-gnu"|tee -a "$LINGLONG_COMMAND"
#echo "export CFLAGS='--sysroot=$PREFIX'"|tee -a "$LINGLONG_COMMAND"
echo "export CPATH='$PREFIX/include:$PREFIX/include/i386-linux-gnu/'"|tee -a "$LINGLONG_COMMAND"
echo "export LIBRARY_PATH='$PREFIX/lib/i386-linux-gnu'"|tee -a "$LINGLONG_COMMAND"


echo "alias 'gcc=gcc --sysroot=$PREFIX'"|tee -a "$PREFIX/.bashrc"
echo "alias 'ld=ld --sysroot=$PREFIX'"|tee -a "$PREFIX/.bashrc"
chmod +x "$PREFIX/.bashrc"
grep /lib/ld-linux.so.2 $PREFIX -rl|xargs -n1 perl -i -pe 's|/lib/ld-linux.so.2|/x32/ld-linux.so.2|g'
