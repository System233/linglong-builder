#!/bin/bash

echo 'mkdir -p /opt/apps/net.zhuoaninfo.pdf417.creator/entries/applications/' | tee -a $LINGLONG_COMMAND
echo 'mkdir -p /opt/apps/net.zhuoaninfo.pdf417.creator/files/bin' | tee -a $LINGLONG_COMMAND
echo 'ln -sf ~/.config/Setting.ini /opt/apps/net.zhuoaninfo.pdf417.creator/files/bin/Setting.ini'| tee -a $LINGLONG_COMMAND
echo 'cp $PREFIX/bin/Setting.ini ~/.config/Setting.ini -n' | tee -a $LINGLONG_COMMAND
echo 'sed -i "s+\$HOME+$HOME+" ~/.config/Setting.ini' | tee -a $LINGLONG_COMMAND
echo 'mkdir -p $HOME/Pictures/barcorder/' | tee -a $LINGLONG_COMMAND
echo 'touch /opt/apps/net.zhuoaninfo.pdf417.creator/entries/applications/net.zhuoaninfo.pdf417.creator.desktop' | tee -a $LINGLONG_COMMAND
