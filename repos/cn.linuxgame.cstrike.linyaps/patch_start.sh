#!/bin/bash

ROOT=$PREFIX/bin/cstrike
echo "mkdir -p \$HOME/.config/cstrike 2>/dev/null"|tee -a $LINGLONG_COMMAND
echo "ln -sf $PREFIX/lib /x32" |tee -a $LINGLONG_COMMAND
echo "export LD_LIBRARY_PATH=$PREFIX/lib/i386-linux-gnu:$PREFIX/bin/cstrike:$PREFIX/bin/cstrike/steam-runtime/i386/usr/lib/i386-linux-gnu/:$PREFIX/bin/cstrike/steam-runtime/i386/lib/i386-linux-gnu/" |tee -a $LINGLONG_COMMAND
echo "export LIBGL_DRIVERS_PATH=$PREFIX/lib/i386-linux-gnu/dri/" |tee -a $LINGLONG_COMMAND
echo "cd $PREFIX/bin/cstrike" |tee -a $LINGLONG_COMMAND
echo "exec ptrace \"\$HOME/.config/cstrike\" ./hl_linux  -game cstrike -dll addons/metamod/dlls/metamod.so \$@"  |tee -a $LINGLONG_COMMAND
cp -af /project/ptrace $PREFIX/bin/
chmod -v +x $PREFIX/bin/ptrace
grep /lib/ld-linux.so.2 $PREFIX -rl|xargs -n1 perl -i -pe 's|/lib/ld-linux.so.2|/x32/ld-linux.so.2|g'
