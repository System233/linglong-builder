#!/bin/bash

sed -i -e 's#com.szca.signproducttool/files#com.szca.signproducttool.linyaps/files#g' -e 's#}&#}#g' $PREFIX/*.sh
rm -vf $PREFIX/lib/libQt5*
