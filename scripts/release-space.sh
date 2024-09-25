#!/bin/bash
function clear_repo() {
    REPO=--repo=$1
    sudo ostree refs $REPO | grep -vP "deepin|foundation" | sudo xargs -r ostree refs "$REPO" --delete
    sudo ostree prune $REPO --refs-only
}
ll-cli list | sed '1d' | cut -d' ' -f1 | xargs -I{} sh -c 'll-cli uninstall {}||true'
ls $HOME/.cache/linglong-builder/layers/main/ | grep -vP "deepin|foundation" | sudo xargs -I{} rm -rf $HOME/.cache/linglong-builder/layers/main/{}

clear_repo $HOME/.cache/linglong-builder/repo
clear_repo /var/lib/linglong/repo
