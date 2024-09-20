#!/bin/bash

rm $PREFIX/bin/chromium-browser-stable
echo '#!/bin/bash' >$PREFIX/bin/chromium-browser-stable
echo "$PREFIX/opt/chromium.org/chromium/chromium-browser \$@" >>$PREFIX/bin/chromium-browser-stable
chmod -v +x  $PREFIX/bin/chromium-browser-stable
#ln -svf $PREFIX/opt/chromium.org/chromium/chromium-browser $PREFIX/bin/chromium-browser-stable
#/opt/apps/duoyu-browser.linyaps/files/opt/chromium.org/chromium/chromium-browser /opt/apps/duoyu-browser.linyaps/files/bin/chromium-browser-stable
