#!/bin/bash

while read icon;do
	NAME=`echo $icon|sed -e 's#com.wind.wfc.svg#com.wind.wfc.linyaps_com.wind.wfc.svg#'`
	cp -afv "$icon" "$NAME"

done <<<`find $PREFIX/share/icons/ -name "com.wind.wfc.svg"`
