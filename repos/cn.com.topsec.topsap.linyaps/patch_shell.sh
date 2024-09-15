#!/bin/bash
echo Patch TopSAP.sh
sed -i -e "s#cn.com.topsec.topsap#cn.com.topsec.topsap.linyaps#g" $PREFIX/bin/TopSAP.sh