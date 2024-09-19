#!/bin/bash

sed -i -e 's#\s*&&\s*./#/#' -e 's#cd\s*##' $PREFIX/share/applications/*.desktop
