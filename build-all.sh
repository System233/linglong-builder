#!/bin/bash
while read line; do
    ./build_target.sh $line.linyaps
done <filter.list
