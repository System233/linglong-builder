#!/bin/bash

sed -i "s#/opt/apps/mct#$PREFIX/opt/apps/mct#g" $PREFIX/opt/apps/mct/bin/mct.sh
sed -i "s#/opt/apps/mct#$PREFIX/opt/apps/mct#g"  $PREFIX/share/applications/*.desktop
