#!/bin/bash
# generated by ll-helper

echo Applying Patch: gtk3-im-base
mkdir -vp $PREFIX/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/
/lib/x86_64-linux-gnu/libgtk-3-0/gtk-query-immodules-3.0 /lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/* > $PREFIX/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules.cache
echo "export GTK_IM_MODULE_FILE=$PREFIX/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules.cache" | tee -a $LINGLONG_COMMAND