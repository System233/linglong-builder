#!/bin/bash

DIR=$(dirname $(readlink -f "$BASH_SOURCE"))
export PATH=$PATH:$DIR

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
alias "llrb=ll-rebase"
alias "llf=ll-find"

alias "llel=ll-builder export -l"

alias "llt=ll-test"
alias "llclr=ll-clear"

export DISPLAY=${DISPLAY:-:0}
