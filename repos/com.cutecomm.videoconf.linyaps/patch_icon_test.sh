#!/bin/bash
ID=102
for i in 16 24 32 48 128 256 512; do
	mkdir -p $PREFIX/share/icons/hicolor/${i}x${i}/apps/
	#cp -avf $PREFIX/share/icons/hicolor/256x256/apps/com.cutecomm.videoconf.linyaps_com.cutecomm.videoconf.png $PREFIX/share/icons/hicolor/${i}x${i}/apps/test.png;
	cp /project/test${i}.png $PREFIX/share/icons/hicolor/${i}x${i}/apps/test${ID}.png
	chmod -v 777 $PREFIX/share/icons/hicolor/${i}x${i}/apps/test${ID}.png
done
mkdir -v -p $PREFIX/share/icons/hicolor/scalable/apps/
cp /project/test128.png $PREFIX/share/icons/hicolor/scalable/apps/test${ID}.png

chmod -v 777 $PREFIX/share/icons/hicolor/scalable/apps/test${ID}.png
sed -i -E -e "s#com.cutecomm.videoconf.linyaps_com.cutecomm.videoconf#test${ID}#g" $PREFIX/share/applications/*.desktop
