#!/bin/bash

export PATH=$PATH:$(dirname $(readlink -f "$BASH_SOURCE"))

alias "llel=ll-builder export -l"
alias "lltest=ll-cli uninstall $(basename $(readlink -f .));ll-cli install $(basename $(readlink -f .))*_binary.layer"

alias "llt=test.sh"
