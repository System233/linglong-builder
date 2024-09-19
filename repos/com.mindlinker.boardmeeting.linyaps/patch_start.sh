#!/bin/bash

sed -i -e 's# && ./#/#' -e 's#cd ##' $PREFIX/share/applications/*.desktop
