#!/bin/bash

DIR=$1
YAML=$DIR/linglong.yaml
BASE=$(grep -oP '^base:\s*\K.*' "$YAML")
RUNTIME=$(grep -oP '^runtime:\s*\K.*' "$YAML")
echo base=$BASE
echo runtime=$RUNTIME
sed -i -E -e "/^base:/c base: $BASE" -e "/^runtime:/c runtime: $RUNTIME" "linglong.yaml"
cp -avf "$DIR/base.packages.list" "$DIR/runtime.packages.list" "$DIR/sources.list" .
rm linglong/sources/*
