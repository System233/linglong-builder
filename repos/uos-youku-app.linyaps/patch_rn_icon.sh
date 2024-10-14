#!/bin/bash
while read IMAGE;do
	if basename $IMAGE|grep -q ${LINGLONG_APP_ID};then
		continue
	fi
	DIR=$(dirname $IMAGE)
	TO=$DIR/${LINGLONG_APP_ID}_$(basename $IMAGE)
	mv -v $IMAGE $TO
done<<<`find $PREFIX/share/icons/ -path '*/apps/*' '(' -name '*.png' -o -name '*.svg' ')'`
# rm wrong icon
rm -rvf $PREFIX/share/icons/hicolor/16x16
