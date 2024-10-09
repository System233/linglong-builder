#!/bin/bash

sed -i -e 's/Terminal=ture/Terminal=false/g' $PREFIX/share/applications/*
