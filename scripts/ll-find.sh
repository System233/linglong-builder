#!/bin/bash
#cat missing.list | xargs -I{} -n1 apt-file find '/{}' | grep -oP '^lib[^:]+' | sort -u | tee -a deps.list

echo >>deps.list
apt-cli find --cache-dir ~/.cache/linglong-helper -f sources.list $(cat missing.list | paste -sd '|') | grep -oP '^lib[^:]+' | grep -oP '^lib[^:]+' | sort -u | tee -a deps.list
