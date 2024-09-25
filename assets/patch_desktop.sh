#!/bin/bash

sed -i -E -e '/^$/d' -e '/^#.*$/d' -e 's#^\s+##g' $PREFIX/share/application/*.desktop
