#!/bin/bash

sed -i -E -e 's#^\s+##g' $PREFIX/share/applications/*.desktop
