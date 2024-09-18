#!/bin/bash

export PATH=$PATH:$(dirname $(readlink -f "$BASH_SOURCE"))

alias "llb=ll-builder build"
alias "llr=ll-builder run"
alias "llbe=ll-builder build --exec bash"
alias "llre=ll-builder run --exec bash"

alias "lle=ll-builder export"

alias "llcr=ll-cli run"
alias "llci=ll-cli install"
alias "llcu=ll-cli uninstall"
alias "llcl=ll-cli list"
alias "llcp=ll-cli ps"
alias "llcs=rm linglong/sources/*.deb"

alias "llu=ll-helper update --cache-dir ~/.cache/linglong-helper"
alias "llf=apt-cli find --cache-dir ~/.cache/linglong-helper -f sources.list"

alias "llel=ll-builder export -l"
alias "lltest=ll-cli uninstall $(basename $(readlink -f .));ll-cli install $(basename $(readlink -f .))*_binary.layer"

alias "llt=test.sh"
