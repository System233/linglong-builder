#!/bin/bash

sed -i -E -e "s#/opt/hscore#$PREFIX/opt/hscore#g" $PREFIX/opt/hscore/launcher 
