#!/bin/bash

rm -vf $PREFIX/bin/nd-office-startup.sh
echo "$PREFIX/Jre/bin/java -jar -XX:+UseG1GC -XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=30 -Xmaxjitcodesize480m -Xverify:none -Djava.java2d.ddlock=true -Djava.awt.noerasebackground=true -Djava.java2d.noddraw=true $PREFIX/NDOffice.jar "|tee -a $PREFIX/bin/nd-office-startup.sh

chmod +x $PREFIX/bin/nd-office-startup.sh
